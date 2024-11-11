module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 3.0"

  resource_group = module.rg.groups.demo.name

  zones = {
    public = {
      globex = {
        name    = "globex.com"
        records = local.records
        soa_record = {
          email         = "hostmaster.globex.com"
          ttl           = 3600
          expire_time   = 2419200
          retry_time    = 600
          minimum_ttl   = 300
          refresh_time  = 3600
          serial_number = 2024102901
          tags = {
            environment = "production"
          }
        }
      }
    }
  }
}
