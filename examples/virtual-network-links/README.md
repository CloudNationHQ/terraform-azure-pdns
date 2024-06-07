This example shows how to set up multiple virtual network links for each private dns zone.

## Usage

```hcl
module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 0.3"

  resourcegroup = module.rg.groups.demo.name

  zones = {
    vault = {
      name = "privatelink.vaultcore.azure.net"

      virtual_network_links = local.virtual_network_links
    }
  }
}
```

The module uses the below locals for configuration

```hcl
locals {
  virtual_network_links = {
    link1 = {
      virtual_network_id   = module.network.vnet.id
      registration_enabled = true
    }
    link2 = {
      virtual_network_id   = module.network2.vnet.id
      registration_enabled = true
    }
  }
}
```
