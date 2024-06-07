This example illustrates the default private dns zones setup, in its simplest form.

## Usage

```hcl
module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 0.3"

  resourcegroup = module.rg.groups.demo.name

  zones = local.zones
}
```

The module uses the below locals for configuration

```hcl
locals {
  zones = {
    vault = {
      name = "privatelink.vaultcore.azure.net"
    },
    sql = {
      name = "privatelink.database.windows.net"
    },
    storage = {
      name = "privatelink.blob.core.windows.net"
    },
  }
}
```
