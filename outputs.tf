output "private_zones" {
  description = "Contains all private DNS zones (new, existing, and predefined)"
  value = merge(
    # Regular private zones
    {
      for zone_key, zone in try(var.zones.private, {}) : zone_key => {
        id   = try(zone.use_existing_zone, false) ? try(data.azurerm_private_dns_zone.existing_zone[zone_key].id, null) : try(azurerm_private_dns_zone.zone[zone_key].id, null)
        name = try(zone.use_existing_zone, false) ? try(data.azurerm_private_dns_zone.existing_zone[zone_key].name, null) : try(azurerm_private_dns_zone.zone[zone_key].name, null)
      }
      if !tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    },
    # Predefined zones
    {
      for name, zone in var.predefined_private_dns_zones : name => {
        id   = try(azurerm_private_dns_zone.zone[name].id, null)
        name = try(azurerm_private_dns_zone.zone[name].name, null)
      }
      if tobool(try(lookup(var.zones.private, "use_predefined_zones", false), false))
    }
  )
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
