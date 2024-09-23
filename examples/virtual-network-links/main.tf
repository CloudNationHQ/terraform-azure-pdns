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

module "network1" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 3.0"

  naming = local.naming

  vnet = {
    name           = "vnet1-demo-dev"
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
    cidr           = ["10.19.0.0/16"]

    subnets = {
      sn1 = {
        cidr = ["10.19.1.0/24"]
      }
    }
  }
}

module "network2" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 3.0"

  naming = local.naming

  vnet = {
    name           = "vnet2-demo-dev"
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
    cidr           = ["10.20.0.0/16"]

    subnets = {
      sn1 = {
        cidr = ["10.20.1.0/24"]
      }
    }
  }
}

module "private_dns" {
  source  = "cloudnationhq/pdns/azure"
  version = "~> 1.0"

  resource_group = module.rg.groups.demo.name

  zones = {
    vault = {
      name                  = "privatelink.vaultcore.azure.net"
      virtual_network_links = local.virtual_network_links
    }
  }
}
