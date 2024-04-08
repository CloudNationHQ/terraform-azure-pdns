output "zones" {
  description = "contains private dns zones"
  value = {
    for key, val in local.zones : key => val.use_existing_zone == true ? try(data.azurerm_private_dns_zone.existing_zone[key], null) : try(azurerm_private_dns_zone.zone[key], null)
  }
}
