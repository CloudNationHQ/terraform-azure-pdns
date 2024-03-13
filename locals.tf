locals {
  zones = {
    for zone_key, zone in var.zones : zone_key => {
      name              = zone.name
      resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
      use_existing_zone = try(zone.use_existing_zone, false)
      tags              = try(zone.tags, var.tags, null)
    }
  }
}

locals {
  links = flatten([
    for zone_key, zone in var.zones : [
      for link_key, link in lookup(zone, "virtual_network_links", {}) : {

        zone_key              = zone_key
        link_key              = link_key
        name                  = zone.name
        resourcegroup         = try(zone.resourcegroup, var.resourcegroup)
        virtual_network_id    = link.virtual_network_id
        private_dns_zone_name = try(zone.use_existing_zone, false) ? data.azurerm_private_dns_zone.existing_zone[zone_key].name : azurerm_private_dns_zone.zone[zone_key].name
        registration_enabled  = try(link.registration_enabled, false)
        tags                  = try(link.tags, var.tags, null)
      }
    ]
  ])
}

locals {
  a = flatten([
    for zone_key, zone in var.zones : [
      for a_key, a in try(zone.records.a, {}) : {

        zone_key          = zone_key
        a_key             = a_key
        resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
        name              = a.name
        ttl               = a.ttl
        records           = a.records
        use_existing_zone = try(zone.use_existing_zone, false)
        tags              = try(a.tags, var.tags, null)
      }
    ]
  ])
}

locals {
  cname = flatten([
    for zone_key, zone in var.zones : [
      for cname_key, cname in try(zone.records.cname, {}) : {

        zone_key          = zone_key
        cname_key         = cname_key
        resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
        name              = cname.name
        ttl               = cname.ttl
        record            = cname.record
        use_existing_zone = try(zone.use_existing_zone, false)
        tags              = try(cname.tags, var.tags, null)
      }
    ]
  ])
}

locals {
  ptr = flatten([
    for zone_key, zone in var.zones : [
      for ptr_key, ptr in try(zone.records.ptr, {}) : {

        zone_key          = zone_key
        ptr_key           = ptr_key
        resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
        name              = ptr.name
        ttl               = ptr.ttl
        records           = ptr.records
        use_existing_zone = try(zone.use_existing_zone, false)
        tags              = try(ptr.tags, var.tags, null)
      }
    ]
  ])
}

locals {
  srv = flatten([
    for zone_key, zone in var.zones : [
      for srv_key, srv in try(zone.records.srv, {}) : {
        zone_key          = zone_key
        srv_key           = srv_key
        resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
        name              = srv.name
        ttl               = srv.ttl
        records           = srv.records
        use_existing_zone = try(zone.use_existing_zone, false)
        tags              = try(srv.tags, var.tags, null)
      }
    ]
  ])
}

locals {
  txt = flatten([
    for zone_key, zone in var.zones : [
      for txt_key, txt in try(zone.records.txt, {}) : {
        zone_key          = zone_key
        txt_key           = txt_key
        resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
        name              = txt.name
        ttl               = txt.ttl
        records           = txt.records
        use_existing_zone = try(zone.use_existing_zone, false)
        tags              = try(txt.tags, var.tags, null)
      }
    ]
  ])
}

locals {
  mx = flatten([
    for zone_key, zone in var.zones : [
      for mx_key, mx in try(zone.records.mx, {}) : {
        zone_key          = zone_key
        mx_key            = mx_key
        resourcegroup     = try(zone.resourcegroup, var.resourcegroup)
        name              = mx.name
        ttl               = mx.ttl
        records           = mx.records
        use_existing_zone = try(zone.use_existing_zone, false)
        tags              = try(mx.tags, var.tags, null)
      }
    ]
  ])
}
