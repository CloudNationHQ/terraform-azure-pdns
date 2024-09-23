module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 1.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "westeurope"
    }
  }
}

module "private_dns" {
  source  = "cloudnationhq/pdns/azure/"
  version = "~> 1.0"

  resource_group = module.rg.groups.demo.name
  zones          = local.zones
}
