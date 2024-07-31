module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.1"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 0.1"

  groups = {
    demo = {
      name   = module.naming.resource_group.name
      region = "westeurope"
    }
  }
}

module "private_dns" {
  source  = "cloudnationhq/sa/azure//modules/private-dns"
  version = "~> 0.1"

  resourcegroup = module.rg.groups.demo.name
  zones         = local.zones

}
