This example demonstrates leveraging existing private dns zones through a provider alias.

## Usage

```hcl
module "private_dns" {
  source  = "cloudnationhq/pdns/azure/"
  version = "~> 0.3"

  providers = {
    azurerm = azurerm.connectivity
  }

  resourcegroup = "rg-demo-zones"
  zones         = local.zones
}
```

The module uses the below locals for configuration

```hcl
locals {
  zones = {
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
```

An additional provider block is required to establish the alias, as shown below

```hcl
provider "azurerm" {
  alias           = "connectivity"
  subscription_id = "00000000-0000-0000-0000-000000000000"
  features {}
}
```
