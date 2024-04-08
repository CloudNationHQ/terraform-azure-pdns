# existing
data "azurerm_private_dns_zone" "existing_zone" {
  for_each = {
    for key, val in local.zones :
    key => val if val.use_existing_zone == true
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
  tags                = each.value.tags
}

resource "azurerm_private_dns_zone" "zone" {
  for_each = {
    for key, val in local.zones :
    key => val if val.use_existing_zone == false
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
  tags                = each.value.tags
}

# records
resource "azurerm_private_dns_a_record" "a" {
  for_each = {
    for a in local.a : "${a.zone_key}.${a.a_key}" => a
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags
}

resource "azurerm_private_dns_cname_record" "cname" {
  for_each = {
    for cname in local.cname : "${cname.zone_key}.${cname.cname_key}" => cname
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
  ttl                 = each.value.ttl
  record              = each.value.record
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags
}

resource "azurerm_private_dns_ptr_record" "ptr" {
  for_each = {
    for ptr in local.ptr : "${ptr.zone_key}.${ptr.ptr_key}" => ptr
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
  ttl                 = each.value.ttl
  records             = each.value.records
  zone_name           = each.value.use_existing_zone ? data.azurerm_private_dns_zone.existing_zone[each.value.zone_key].name : azurerm_private_dns_zone.zone[each.value.zone_key].name
  tags                = each.value.tags
}

resource "azurerm_private_dns_srv_record" "srv" {
  for_each = {
    for srv in local.srv : "${srv.zone_key}.${srv.srv_key}" => srv
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
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
    for txt in local.txt : "${txt.zone_key}.${txt.txt_key}" => txt
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
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
    for mx in local.mx : "${mx.zone_key}.${mx.mx_key}" => mx
  }

  name                = each.value.name
  resource_group_name = each.value.resourcegroup
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
    for link in local.links : "${link.zone_key}-${link.link_key}" => link
  }

  name                  = each.value.link_key
  resource_group_name   = each.value.resourcegroup
  private_dns_zone_name = each.value.private_dns_zone_name
  virtual_network_id    = each.value.virtual_network_id
  registration_enabled  = each.value.registration_enabled
}
