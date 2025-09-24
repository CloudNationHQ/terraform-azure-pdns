# existing private dns zones
data "azurerm_private_dns_zone" "existing_zone" {
  for_each = {
    for zone_key, zone in var.zones.private : zone_key => zone
    if var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    zone.use_existing_zone
  }

  name = each.value.name

  resource_group_name = coalesce(
    lookup(each.value, "resource_group_name", null),
    var.resource_group_name
  )
}

# public dns zone
resource "azurerm_dns_zone" "this" {
  for_each = var.zones.public

  name = each.value.name

  resource_group_name = coalesce(
    try(
      each.value.resource_group_name, null
    ), var.resource_group_name
  )

  tags = coalesce(
    try(
      each.value.tags, null
    ), var.tags
  )

  dynamic "soa_record" {
    for_each = try(each.value.soa_record, null) != null ? { "soa" = each.value.soa_record } : {}

    content {
      email         = soa_record.value.email
      ttl           = soa_record.value.ttl
      expire_time   = soa_record.value.expire_time
      retry_time    = soa_record.value.retry_time
      minimum_ttl   = soa_record.value.minimum_ttl
      refresh_time  = soa_record.value.refresh_time
      serial_number = soa_record.value.serial_number
      tags = try(
        soa_record.value.tags, var.tags, null
      )
    }
  }
}

# public dns a records
resource "azurerm_dns_a_record" "a" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for a_key, a in zone.records.a : {
          zone_key = zone_key
          a_key    = a_key
          zone     = zone
          a        = a
        }
      ]
    ]) : "${item.zone_key}.${item.a_key}" => item
  }

  name = try(
    each.value.a.name, each.value.a_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl                = each.value.a.ttl
  records            = each.value.a.records
  zone_name          = azurerm_dns_zone.this[each.value.zone_key].name
  target_resource_id = each.value.a.target_resource_id

  tags = coalesce(
    try(
      each.value.a.tags, null
    ), var.tags
  )
}

# public dns aaaa records
resource "azurerm_dns_aaaa_record" "aaaa" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for aaaa_key, aaaa in zone.records.aaaa : {
          zone_key = zone_key
          aaaa_key = aaaa_key
          zone     = zone
          aaaa     = aaaa
        }
      ]
    ]) : "${item.zone_key}.${item.aaaa_key}" => item
  }

  name = try(
    each.value.aaaa.name, each.value.aaaa_key
  )

  resource_group_name = coalesce(
    lookup(each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl                = each.value.aaaa.ttl
  records            = each.value.aaaa.records
  zone_name          = azurerm_dns_zone.this[each.value.zone_key].name
  target_resource_id = each.value.aaaa.target_resource_id

  tags = coalesce(
    try(
      each.value.aaaa.tags, null
    ), var.tags
  )
}

# public dns caa records
resource "azurerm_dns_caa_record" "caa" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for caa_key, caa in zone.records.caa : {
          zone_key = zone_key
          caa_key  = caa_key
          zone     = zone
          caa      = caa
        }
      ]
    ]) : "${item.zone_key}.${item.caa_key}" => item
  }

  name = try(
    each.value.caa.name, each.value.caa_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl       = each.value.caa.ttl
  zone_name = azurerm_dns_zone.this[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.caa.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.caa.records

    content {
      flags = record.value.flags
      tag   = record.value.tag
      value = record.value.value
    }
  }
}

#public mx records
resource "azurerm_dns_mx_record" "mx" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for mx_key, mx in zone.records.mx : {
          zone_key = zone_key
          mx_key   = mx_key
          zone     = zone
          mx       = mx
        }
      ]
    ]) : "${item.zone_key}.${item.mx_key}" => item
  }

  name = try(
    each.value.mx.name, each.value.mx_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl       = each.value.mx.ttl
  zone_name = azurerm_dns_zone.this[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.mx.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.mx.records

    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
}

# public dns cname records
resource "azurerm_dns_cname_record" "cname" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for cname_key, cname in zone.records.cname : {
          zone_key  = zone_key
          cname_key = cname_key
          zone      = zone
          cname     = cname
        }
      ]
    ]) : "${item.zone_key}.${item.cname_key}" => item
  }

  name = try(
    each.value.cname.name, each.value.cname_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl                = each.value.cname.ttl
  record             = each.value.cname.record
  zone_name          = azurerm_dns_zone.this[each.value.zone_key].name
  target_resource_id = each.value.cname.target_resource_id

  tags = coalesce(
    try(
      each.value.cname.tags, null
    ), var.tags
  )
}

# public dns ns records
resource "azurerm_dns_ns_record" "ns" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for ns_key, ns in zone.records.ns : {
          zone_key = zone_key
          ns_key   = ns_key
          zone     = zone
          ns       = ns
        }
      ]
    ]) : "${item.zone_key}.${item.ns_key}" => item
  }

  name = try(
    each.value.ns.name, each.value.ns_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl       = each.value.ns.ttl
  records   = each.value.ns.records
  zone_name = azurerm_dns_zone.this[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.ns.tags, null
    ), var.tags
  )
}

# public dns ptr records
resource "azurerm_dns_ptr_record" "ptr" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for ptr_key, ptr in zone.records.ptr : {
          zone_key = zone_key
          ptr_key  = ptr_key
          zone     = zone
          ptr      = ptr
        }
      ]
    ]) : "${item.zone_key}.${item.ptr_key}" => item
  }

  name = try(
    each.value.ptr.name, each.value.ptr_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl       = each.value.ptr.ttl
  records   = each.value.ptr.records
  zone_name = azurerm_dns_zone.this[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.ptr.tags, null
    ), var.tags
  )
}

# public dns srv records
resource "azurerm_dns_srv_record" "srv" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for srv_key, srv in zone.records.srv : {
          zone_key = zone_key
          srv_key  = srv_key
          zone     = zone
          srv      = srv
        }
      ]
    ]) : "${item.zone_key}.${item.srv_key}" => item
  }

  name = try(
    each.value.srv.name, each.value.srv_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl       = each.value.srv.ttl
  zone_name = azurerm_dns_zone.this[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.srv.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.srv.records

    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
}

# public dns txt records
resource "azurerm_dns_txt_record" "txt" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.public : [
        for txt_key, txt in zone.records.txt : {
          zone_key = zone_key
          txt_key  = txt_key
          zone     = zone
          txt      = txt
        }
      ]
    ]) : "${item.zone_key}.${item.txt_key}" => item
  }

  name = try(
    each.value.txt.name, each.value.txt_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl       = each.value.txt.ttl
  zone_name = azurerm_dns_zone.this[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.txt.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.txt.records

    content {
      value = record.value
    }
  }
}

# private dns zones
resource "azurerm_private_dns_zone" "zone" {
  for_each = {
    for zone_key, zone in var.zones.private :
    zone_key => zone
    if !var.use_existing_private_dns_zone &&
    !var.zones.use_existing_zone &&
    !zone.use_existing_zone
  }

  name = each.value.name

  resource_group_name = coalesce(
    lookup(each.value, "resource_group_name", null),
    var.resource_group_name
  )

  tags = coalesce(
    try(each.value.tags, null),
    var.tags
  )

  dynamic "soa_record" {
    for_each = try(each.value.soa_record, null) != null ? [each.value.soa_record] : []

    content {
      email        = soa_record.value.email
      expire_time  = soa_record.value.expire_time
      minimum_ttl  = soa_record.value.minimum_ttl
      refresh_time = soa_record.value.refresh_time
      retry_time   = soa_record.value.retry_time
      ttl          = soa_record.value.ttl
      tags = try(
        soa_record.value.tags, var.tags, null
      )
    }
  }
}

# private dns a records
resource "azurerm_private_dns_a_record" "a" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for a_key, a in zone.records.a : {
          zone_key = zone_key
          a_key    = a_key
          zone     = zone
          a        = a
        }
      ]
    ]) : "${item.zone_key}.${item.a_key}" => item
  }

  name = try(
    each.value.a.name, each.value.a_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl     = each.value.a.ttl
  records = each.value.a.records

  zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.a.tags, null
    ), var.tags
  )
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for cname_key, cname in zone.records.cname : {
          zone_key  = zone_key
          cname_key = cname_key
          zone      = zone
          cname     = cname
        }
      ]
    ]) : "${item.zone_key}.${item.cname_key}" => item
  }

  name = try(
    each.value.cname.name, each.value.cname_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl    = each.value.cname.ttl
  record = each.value.cname.record

  zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.cname.tags, null
    ), var.tags
  )
}

resource "azurerm_private_dns_ptr_record" "ptr" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for ptr_key, ptr in zone.records.ptr : {
          zone_key = zone_key
          ptr_key  = ptr_key
          zone     = zone
          ptr      = ptr
        }
      ]
    ]) : "${item.zone_key}.${item.ptr_key}" => item
  }

  name = try(
    each.value.ptr.name, each.value.ptr_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl     = each.value.ptr.ttl
  records = each.value.ptr.records

  zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.ptr.tags, null
    ), var.tags
  )
}

resource "azurerm_private_dns_srv_record" "srv" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for srv_key, srv in zone.records.srv : {
          zone_key = zone_key
          srv_key  = srv_key
          zone     = zone
          srv      = srv
        }
      ]
    ]) : "${item.zone_key}.${item.srv_key}" => item
  }

  name = try(
    each.value.srv.name, each.value.srv_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl = each.value.srv.ttl

  zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.srv.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.srv.records

    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }
}

resource "azurerm_private_dns_txt_record" "txt" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for txt_key, txt in zone.records.txt : {
          zone_key = zone_key
          txt_key  = txt_key
          zone     = zone
          txt      = txt
        }
      ]
    ]) : "${item.zone_key}.${item.txt_key}" => item
  }

  name = try(
    each.value.txt.name, each.value.txt_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl = each.value.txt.ttl

  zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.txt.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.txt.records

    content {
      value = record.value
    }
  }
}

resource "azurerm_private_dns_mx_record" "mx" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for mx_key, mx in zone.records.mx : {
          zone_key = zone_key
          mx_key   = mx_key
          zone     = zone
          mx       = mx
        }
      ]
    ]) : "${item.zone_key}.${item.mx_key}" => item
  }

  name = try(
    each.value.mx.name, each.value.mx_key
  )

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  ttl = each.value.mx.ttl

  zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  tags = coalesce(
    try(
      each.value.mx.tags, null
    ), var.tags
  )

  dynamic "record" {
    for_each = each.value.mx.records

    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
}

# virtual network links
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones.private : [
        for link_key, link in coalesce(
          lookup(zone, "virtual_network_links", null),
          var.virtual_network_links
          ) : {
          zone_key = zone_key
          link_key = link_key
          zone     = zone
          link     = link
        }
      ]
    ]) : "${item.zone_key}-${item.link_key}" => item
  }

  name = each.value.link_key

  resource_group_name = coalesce(
    lookup(
      each.value.zone, "resource_group_name", null
    ), var.resource_group_name
  )

  private_dns_zone_name = (var.use_existing_private_dns_zone ||
    var.zones.use_existing_zone ||
    each.value.zone.use_existing_zone
  ) ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name

  virtual_network_id   = each.value.link.virtual_network_id
  registration_enabled = each.value.link.registration_enabled
  resolution_policy    = each.value.link.resolution_policy

  tags = coalesce(
    try(
      each.value.link.tags, null
    ), var.tags
  )

  lifecycle {
    create_before_destroy = true
  }
}
