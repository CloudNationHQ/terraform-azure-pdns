output "private_zones" {
  description = "Contains all private DNS zones (both new and existing)"
  value = {
    for zone_key, zone in try(var.zones.private, {}) : zone_key => {
      id   = try(zone.use_existing_zone, false) ? try(data.azurerm_private_dns_zone.existing_zone[zone_key].id, null) : try(azurerm_private_dns_zone.zone[zone_key].id, null)
      name = try(zone.use_existing_zone, false) ? try(data.azurerm_private_dns_zone.existing_zone[zone_key].name, null) : try(azurerm_private_dns_zone.zone[zone_key].name, null)
    }
  }
}

output "public_zones" {
  description = "Contains all public DNS zones"
  value = {
    for zone_key, zone in try(var.zones.public, {}) : zone_key => {
      id   = try(azurerm_dns_zone.this[zone_key].id, null)
      name = try(azurerm_dns_zone.this[zone_key].name, null)
    }
  }
}
