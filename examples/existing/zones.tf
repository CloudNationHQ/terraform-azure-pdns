locals {
  zones = {
    private = {
      vault = {
        name              = "privatelink.vaultcore.azure.net"
        use_existing_zone = true

        virtual_network_links = {
          link1 = {
            virtual_network_id   = module.network.vnet.id
            registration_enabled = true
          }
        }
      }
    }
  }
}
