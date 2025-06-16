# public dns zone
resource "azurerm_dns_zone" "this" {
  for_each = {
    for k, v in lookup(var.zones, "public", {}) : k => {
      name           = v.name
      resource_group = try(v.resource_group, var.resource_group)
      tags           = try(v.tags, var.tags, null)
    }
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  tags                = each.value.tags

  dynamic "soa_record" {
    for_each = try(var.zones.public[each.key].soa_record, null) != null ? { "soa" = var.zones.public[each.key].soa_record } : {}

    content {
      tags          = try(soa_record.value.tags, var.tags, null)
      email         = soa_record.value.email
      ttl           = try(soa_record.value.ttl, 3600)
      expire_time   = try(soa_record.value.expire_time, 2419200)
      retry_time    = try(soa_record.value.retry_time, 300)
      minimum_ttl   = try(soa_record.value.minimum_ttl, 300)
      refresh_time  = try(soa_record.value.refresh_time, 3600)
      serial_number = try(soa_record.value.serial_number, 1)
    }
  }
}

# public dns a records
resource "azurerm_dns_a_record" "a" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for a_key, a in lookup(lookup(zone, "records", {}), "a", {}) : {
          zone_key           = zone_key
          a_key              = a_key
          resource_group     = try(zone.resource_group, var.resource_group)
          name               = a.name
          ttl                = a.ttl
          records            = a.records
          tags               = try(a.tags, var.tags, null)
          target_resource_id = try(a.target_resource_id, null)
        }
      ]
    ]) : "${item.zone_key}.${item.a_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags
  target_resource_id  = each.value.target_resource_id
}

# public dns aaaa records
resource "azurerm_dns_aaaa_record" "aaaa" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for aaaa_key, aaaa in lookup(lookup(zone, "records", {}), "aaaa", {}) : {
          zone_key           = zone_key
          aaaa_key           = aaaa_key
          resource_group     = try(zone.resource_group, var.resource_group)
          name               = aaaa.name
          ttl                = aaaa.ttl
          records            = aaaa.records
          tags               = try(aaaa.tags, var.tags, null)
          target_resource_id = try(aaaa.target_resource_id, null)
        }
      ]
    ]) : "${item.zone_key}.${item.aaaa_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags
  target_resource_id  = each.value.target_resource_id
}

# public dns caa records
resource "azurerm_dns_caa_record" "caa" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for caa_key, caa in lookup(lookup(zone, "records", {}), "caa", {}) : {
          zone_key       = zone_key
          caa_key        = caa_key
          resource_group = try(zone.resource_group, var.resource_group)
          name           = caa.name
          ttl            = caa.ttl
          records        = caa.records
          tags           = try(caa.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}.${item.caa_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records
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
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for mx_key, mx in lookup(lookup(zone, "records", {}), "mx", {}) : {
          zone_key       = zone_key
          mx_key         = mx_key
          resource_group = try(zone.resource_group, var.resource_group)
          name           = mx.name
          ttl            = mx.ttl
          records        = mx.records
          tags           = try(mx.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}.${item.mx_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records

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
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for cname_key, cname in lookup(lookup(zone, "records", {}), "cname", {}) : {
          zone_key           = zone_key
          cname_key          = cname_key
          resource_group     = try(zone.resource_group, var.resource_group)
          name               = cname.name
          ttl                = cname.ttl
          record             = cname.record
          tags               = try(cname.tags, var.tags, null)
          target_resource_id = try(cname.target_resource_id, null)
        }
      ]
    ]) : "${item.zone_key}.${item.cname_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  record              = each.value.record
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags
  target_resource_id  = each.value.target_resource_id
}

# public dns ns records
resource "azurerm_dns_ns_record" "ns" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for ns_key, ns in lookup(lookup(zone, "records", {}), "ns", {}) : {
          zone_key       = zone_key
          ns_key         = ns_key
          resource_group = try(zone.resource_group, var.resource_group)
          name           = ns.name
          ttl            = ns.ttl
          records        = ns.records
          tags           = try(ns.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}.${item.ns_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags
}

# public dns ptr records
resource "azurerm_dns_ptr_record" "ptr" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for ptr_key, ptr in lookup(lookup(zone, "records", {}), "ptr", {}) : {
          zone_key       = zone_key
          ptr_key        = ptr_key
          resource_group = try(zone.resource_group, var.resource_group)
          name           = ptr.name
          ttl            = ptr.ttl
          records        = ptr.records
          tags           = try(ptr.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}.${item.ptr_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags
}

# public dns srv records
resource "azurerm_dns_srv_record" "srv" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for srv_key, srv in lookup(lookup(zone, "records", {}), "srv", {}) : {
          zone_key       = zone_key
          srv_key        = srv_key
          resource_group = try(zone.resource_group, var.resource_group)
          name           = srv.name
          ttl            = srv.ttl
          records        = srv.records
          tags           = try(srv.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}.${item.srv_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records
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
      for zone_key, zone in lookup(var.zones, "public", {}) : [
        for txt_key, txt in lookup(lookup(zone, "records", {}), "txt", {}) : {
          zone_key       = zone_key
          txt_key        = txt_key
          resource_group = try(zone.resource_group, var.resource_group)
          name           = txt.name
          ttl            = txt.ttl
          records        = txt.records
          tags           = try(txt.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}.${item.txt_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = azurerm_dns_zone.this[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}

# existing private dns zones
data "azurerm_private_dns_zone" "existing_zone" {
  for_each = {
    for zone_key, zone in lookup(var.zones, "private", {}) :
    zone_key => {
      name              = zone.name
      resource_group    = try(zone.resource_group, var.resource_group)
      use_existing_zone = try(zone.use_existing_zone, false)
    }
    if try(zone.use_existing_zone, false) == true
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
}

# private dns zones
resource "azurerm_private_dns_zone" "zone" {
  for_each = merge(
    {
      # individual zones
      for zone_key, zone in lookup(var.zones, "private", {}) :
      zone_key => {
        name           = zone.name
        resource_group = try(zone.resource_group, var.resource_group)
        soa_record     = try(zone.soa_record, null)
        tags           = try(zone.tags, var.tags, null)
      }
      if try(zone.use_existing_zone, false) == false && !tobool(try(var.zones.private.use_predefined_zones, false))
    },
    {
      # predefined zones
      for name, zone in var.predefined_private_dns_zones :
      name => {
        name           = zone.name
        resource_group = var.resource_group
        soa_record     = try(zone.soa_record, null)
        tags           = var.tags
      }
      if try(lookup(var.zones.private, "use_predefined_zones", false), false)
    }
  )

  name                = each.value.name
  resource_group_name = each.value.resource_group
  tags                = each.value.tags

  dynamic "soa_record" {
    for_each = each.value.soa_record != null ? [each.value.soa_record] : []

    content {
      email        = soa_record.value.email
      expire_time  = try(soa_record.value.expire_time, 2419200)
      minimum_ttl  = try(soa_record.value.minimum_ttl, 10)
      refresh_time = try(soa_record.value.refresh_time, 3600)
      retry_time   = try(soa_record.value.retry_time, 300)
      ttl          = try(soa_record.value.ttl, 3600)
      tags         = soa_record.value.tags
    }
  }
}

# private dns a records
resource "azurerm_private_dns_a_record" "a" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "private", {}) :
      [
        for a_key, a in lookup(lookup(zone, "records", {}), "a", {}) : {
          zone_key          = zone_key
          a_key             = a_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = a.name
          ttl               = a.ttl
          records           = a.records
          tags              = try(a.tags, var.tags, null)
          use_existing_zone = try(zone.use_existing_zone, false)
        }
      ]
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    ]) : "${item.zone_key}.${item.a_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "private", {}) : [
        for cname_key, cname in lookup(lookup(zone, "records", {}), "cname", {}) : {
          zone_key          = zone_key
          cname_key         = cname_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = cname.name
          ttl               = cname.ttl
          record            = cname.record
          tags              = try(cname.tags, var.tags, null)
          use_existing_zone = try(zone.use_existing_zone, false)
        }
      ]
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    ]) : "${item.zone_key}.${item.cname_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  record              = each.value.record
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags
}

resource "azurerm_private_dns_ptr_record" "ptr" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "private", {}) : [
        for ptr_key, ptr in lookup(lookup(zone, "records", {}), "ptr", {}) : {
          zone_key          = zone_key
          ptr_key           = ptr_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = ptr.name
          ttl               = ptr.ttl
          records           = ptr.records
          tags              = try(ptr.tags, var.tags, null)
          use_existing_zone = try(zone.use_existing_zone, false)
        }
      ]
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    ]) : "${item.zone_key}.${item.ptr_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags
}

resource "azurerm_private_dns_srv_record" "srv" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "private", {}) : [
        for srv_key, srv in lookup(lookup(zone, "records", {}), "srv", {}) : {
          zone_key          = zone_key
          srv_key           = srv_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = srv.name
          ttl               = srv.ttl
          records           = srv.records
          tags              = try(srv.tags, var.tags, null)
          use_existing_zone = try(zone.use_existing_zone, false)
        }
      ]
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    ]) : "${item.zone_key}.${item.srv_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records
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
      for zone_key, zone in lookup(var.zones, "private", {}) : [
        for txt_key, txt in lookup(lookup(zone, "records", {}), "txt", {}) : {
          zone_key          = zone_key
          txt_key           = txt_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = txt.name
          ttl               = txt.ttl
          records           = txt.records
          tags              = try(txt.tags, var.tags, null)
          use_existing_zone = try(zone.use_existing_zone, false)
        }
      ]
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    ]) : "${item.zone_key}.${item.txt_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      value = record.value
    }
  }
}

resource "azurerm_private_dns_mx_record" "mx" {
  for_each = {
    for item in flatten([
      for zone_key, zone in lookup(var.zones, "private", {}) : [
        for mx_key, mx in lookup(lookup(zone, "records", {}), "mx", {}) : {
          zone_key          = zone_key
          mx_key            = mx_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = mx.name
          ttl               = mx.ttl
          records           = mx.records
          tags              = try(mx.tags, var.tags, null)
          use_existing_zone = try(zone.use_existing_zone, false)
        }
      ]
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    ]) : "${item.zone_key}.${item.mx_key}" => item
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  ttl                 = each.value.ttl
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.records
    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }
}

# virtual network links
#TODO: submodule because of linking, top level multiple
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each = {
    for item in concat(
      # individual zone links
      flatten([
        for zone_key, zone in lookup(var.zones, "private", {}) : [
          for link_key, link in lookup(zone, "virtual_network_links", {}) : {
            zone_key             = zone_key
            link_key             = link_key
            virtual_network_id   = link.virtual_network_id
            registration_enabled = try(link.registration_enabled, false)
            tags                 = try(link.tags, var.tags, null)
            use_existing_zone    = try(zone.use_existing_zone, false)
            resource_group       = try(zone.resource_group, var.resource_group)
          }
        ]
        if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
      ]),
      # predefined zone links
      flatten([
        for name in keys(var.predefined_private_dns_zones) : [
          for link_key, link in lookup(var.zones.private, "virtual_network_links", {}) : {
            zone_key             = name
            link_key             = link_key
            virtual_network_id   = link.virtual_network_id
            registration_enabled = try(link.registration_enabled, false)
            tags                 = var.tags
            use_existing_zone    = false
            resource_group       = var.resource_group
          }
        ]
        if tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
      ])
    ) : "${item.zone_key}-${item.link_key}" => item
  }

  name                  = each.value.link_key
  resource_group_name   = each.value.resource_group
  private_dns_zone_name = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
  tags                  = each.value.tags

  lifecycle {
    create_before_destroy = true
  }
}
