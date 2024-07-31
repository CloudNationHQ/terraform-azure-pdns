locals {
  virtual_network_links = {
    link1 = {
      virtual_network_id = module.network1.vnet.id
    }
    link2 = {
      virtual_network_id = module.network2.vnet.id
    }
  }
}
