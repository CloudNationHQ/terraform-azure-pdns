This example shows how to set up multiple virtual network links for each private dns zone.

## Usage

```hcl
module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 0.4"

  resourcegroup = module.rg.groups.demo.name

  zones = {
    vault = {
      name    = "privatelink.vaultcore.azure.net"
      records = local.records
    }
  }
}
```

The module uses the below locals for configuration

```hcl
locals {
  records = {
    a = {
      webserver = {
        name    = "webserver"
        ttl     = 3600
        records = ["10.0.0.5"]
      }
      mailserver = {
        name    = "mail"
        ttl     = 3600
        records = ["10.0.0.7"]
      }
    }
    cname = {
      docs = {
        name   = "docs"
        ttl    = 3600
        record = "docs.contoso.com"
      }
      support = {
        name   = "support"
        ttl    = 3600
        record = "support.contoso.com"
      }
    }
    srv = {
      email = {
        name = "email"
        ttl  = 3600
        records = {
          r1 = {
            priority = 10
            weight   = 5
            port     = 25
            target   = "mail.contoso.com"
          }
          r2 = {
            priority = 20
            weight   = 5
            port     = 25
            target   = "altmail.contoso.com"
          }
        }
      }
    }
    txt = {
      spf = {
        name    = "@"
        ttl     = 3600
        records = ["v=spf1 ip4:10.0.0.7 ~all"]
      }
      dmarc = {
        name    = "_dmarc"
        ttl     = 3600
        records = ["v=DMARC1; p=none; rua=mailto:dmarcreports@contoso.com"]
      }
    }
    ptr = {
      ptr1 = {
        name    = "5.0.0.10.in-addr.arpa"
        ttl     = 3600
        records = ["webserver.contoso.com."]
      }
      ptr2 = {
        name    = "7.0.0.10.in-addr.arpa"
        ttl     = 3600
        records = ["mail.contoso.com."]
      }
    }
  }
}
```
