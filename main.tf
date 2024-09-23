# existing
data "azurerm_private_dns_zone" "existing_zone" {
  for_each = {
    for zone_key, zone in var.zones :
    zone_key => {
      name              = zone.name
      resource_group    = try(zone.resource_group, var.resource_group)
      use_existing_zone = try(zone.use_existing_zone, false)
      tags              = try(zone.tags, var.tags, null)
    }
    if try(zone.use_existing_zone, false) == true
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  tags                = each.value.tags
}

resource "azurerm_private_dns_zone" "zone" {
  for_each = {
    for zone_key, zone in var.zones :
    zone_key => {
      name              = zone.name
      resource_group    = try(zone.resource_group, var.resource_group)
      use_existing_zone = try(zone.use_existing_zone, false)
      tags              = try(zone.tags, var.tags, null)
    }
    if try(zone.use_existing_zone, false) == false
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group
  tags                = each.value.tags
}

# records
resource "azurerm_private_dns_a_record" "a" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones : [
        for a_key, a in try(zone.records.a, {}) : {
          zone_key          = zone_key
          a_key             = a_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = a.name
          ttl               = a.ttl
          records           = a.records
          use_existing_zone = try(zone.use_existing_zone, false)
          tags              = try(a.tags, var.tags, null)
        }
      ]
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
      for zone_key, zone in var.zones : [
        for cname_key, cname in try(zone.records.cname, {}) : {
          zone_key          = zone_key
          cname_key         = cname_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = cname.name
          ttl               = cname.ttl
          record            = cname.record
          use_existing_zone = try(zone.use_existing_zone, false)
          tags              = try(cname.tags, var.tags, null)
        }
      ]
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
      for zone_key, zone in var.zones : [
        for ptr_key, ptr in try(zone.records.ptr, {}) : {
          zone_key          = zone_key
          ptr_key           = ptr_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = ptr.name
          ttl               = ptr.ttl
          records           = ptr.records
          use_existing_zone = try(zone.use_existing_zone, false)
          tags              = try(ptr.tags, var.tags, null)
        }
      ]
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
      for zone_key, zone in var.zones : [
        for srv_key, srv in try(zone.records.srv, {}) : {
          zone_key          = zone_key
          srv_key           = srv_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = srv.name
          ttl               = srv.ttl
          records           = srv.records
          use_existing_zone = try(zone.use_existing_zone, false)
          tags              = try(srv.tags, var.tags, null)
        }
      ]
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
      for zone_key, zone in var.zones : [
        for txt_key, txt in try(zone.records.txt, {}) : {
          zone_key          = zone_key
          txt_key           = txt_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = txt.name
          ttl               = txt.ttl
          records           = txt.records
          use_existing_zone = try(zone.use_existing_zone, false)
          tags              = try(txt.tags, var.tags, null)
        }
      ]
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
      for zone_key, zone in var.zones : [
        for mx_key, mx in try(zone.records.mx, {}) : {
          zone_key          = zone_key
          mx_key            = mx_key
          resource_group    = try(zone.resource_group, var.resource_group)
          name              = mx.name
          ttl               = mx.ttl
          records           = mx.records
          use_existing_zone = try(zone.use_existing_zone, false)
          tags              = try(mx.tags, var.tags, null)
        }
      ]
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
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  for_each = {
    for item in flatten([
      for zone_key, zone in var.zones : [
        for link_key, link in lookup(zone, "virtual_network_links", {}) : {
          zone_key              = zone_key
          link_key              = link_key
          name                  = zone.name
          resource_group        = try(zone.resource_group, var.resource_group)
          virtual_network_id    = link.virtual_network_id
          private_dns_zone_name = try(zone.use_existing_zone, false) ? data.azurerm_private_dns_zone.existing_zone[zone_key].name : azurerm_private_dns_zone.zone[zone_key].name
          registration_enabled  = try(link.registration_enabled, false)
          tags                  = try(link.tags, var.tags, null)
        }
      ]
    ]) : "${item.zone_key}-${item.link_key}" => item
  }

  name                  = each.value.link_key
  resource_group_name   = each.value.resource_group
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
}
