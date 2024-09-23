output "zones" {
  description = "contains private dns zones"
  value = {
    for zone_key, zone in var.zones : zone_key =>
    try(zone.use_existing_zone, false) == true ?
    try(data.azurerm_private_dns_zone.existing_zone[zone_key], null) :
    try(azurerm_private_dns_zone.zone[zone_key], null)
  }
}
