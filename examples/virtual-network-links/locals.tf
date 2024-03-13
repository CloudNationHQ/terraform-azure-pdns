locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = ["subnet", "network_security_group"]
}

locals {
  virtual_network_links = {
    link1 = {
      virtual_network_id   = module.network1.vnet.id
      registration_enabled = true
    }
    link2 = {
      virtual_network_id   = module.network2.vnet.id
      registration_enabled = true
    }
  }
}
