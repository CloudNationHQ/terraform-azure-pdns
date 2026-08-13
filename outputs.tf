output "private_zones" {
  description = "Contains all private DNS zones (new and existing)"
  value = {
    for zone_key, zone in try(var.zones.private, {}) : zone_key => (
      try(zone.use_existing_zone, false)
      ? try(data.azurerm_private_dns_zone.existing_zone[zone_key], null)
      : try(azurerm_private_dns_zone.this[zone_key], null)
    )
  }
}

output "public_zones" {
  description = "Contains all public DNS zones"
  value       = azurerm_dns_zone.this
}

output "public_a_records" {
  description = "Contains all public DNS A records"
  value       = azurerm_dns_a_record.this
}

output "public_aaaa_records" {
  description = "Contains all public DNS AAAA records"
  value       = azurerm_dns_aaaa_record.this
}

output "public_caa_records" {
  description = "Contains all public DNS CAA records"
  value       = azurerm_dns_caa_record.this
}

output "public_cname_records" {
  description = "Contains all public DNS CNAME records"
  value       = azurerm_dns_cname_record.this
}

output "public_mx_records" {
  description = "Contains all public DNS MX records"
  value       = azurerm_dns_mx_record.this
}

output "public_ns_records" {
  description = "Contains all public DNS NS records"
  value       = azurerm_dns_ns_record.this
}

output "public_ptr_records" {
  description = "Contains all public DNS PTR records"
  value       = azurerm_dns_ptr_record.this
}

output "public_srv_records" {
  description = "Contains all public DNS SRV records"
  value       = azurerm_dns_srv_record.this
}

output "public_txt_records" {
  description = "Contains all public DNS TXT records"
  value       = azurerm_dns_txt_record.this
}

output "private_a_records" {
  description = "Contains all private DNS A records"
  value       = azurerm_private_dns_a_record.this
}

output "private_cname_records" {
  description = "Contains all private DNS CNAME records"
  value       = azurerm_private_dns_cname_record.this
}

output "private_mx_records" {
  description = "Contains all private DNS MX records"
  value       = azurerm_private_dns_mx_record.this
}

output "private_ptr_records" {
  description = "Contains all private DNS PTR records"
  value       = azurerm_private_dns_ptr_record.this
}

output "private_srv_records" {
  description = "Contains all private DNS SRV records"
  value       = azurerm_private_dns_srv_record.this
}

output "private_txt_records" {
  description = "Contains all private DNS TXT records"
  value       = azurerm_private_dns_txt_record.this
}

output "virtual_network_links" {
  description = "Contains all private DNS zone virtual network links"
  value       = azurerm_private_dns_zone_virtual_network_link.this
}
