mock_provider "azurerm" {
  mock_data "azurerm_private_dns_zone" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-zones/providers/Microsoft.Network/privateDnsZones/mock-existing"
    }
  }
  mock_resource "azurerm_private_dns_zone" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/privateDnsZones/mock-managed"
    }
  }
  mock_resource "azurerm_private_dns_a_record" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/privateDnsZones/mock/A/mock"
    }
  }
  mock_resource "azurerm_private_dns_zone_virtual_network_link" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/privateDnsZones/mock/virtualNetworkLinks/mock"
    }
  }
}

variables {
  resource_group_name = "rg-fallback"
}

run "existing_zone_via_global_flag" {
  command = plan

  variables {
    use_existing_private_dns_zone = true

    zones = {
      private = {
        vault = {
          name                = "privatelink.vaultcore.azure.net"
          resource_group_name = "rg-zones"

          virtual_network_links = {
            link1 = {
              virtual_network_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-net/providers/Microsoft.Network/virtualNetworks/vnet-test"
            }
          }

          records = {
            a = {
              key1 = {
                ttl     = 3600
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_private_dns_zone.existing_zone) == 1 && length(azurerm_private_dns_zone.this) == 0
    error_message = format(
      "the global flag must select the data source, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_private_dns_zone.existing_zone),
      length(azurerm_private_dns_zone.this),
    )
  }

  assert {
    condition = data.azurerm_private_dns_zone.existing_zone["vault"].resource_group_name == "rg-zones"
    error_message = format(
      "existing zone must be looked up in zones.private.vault.resource_group_name (\"rg-zones\"), got %q",
      data.azurerm_private_dns_zone.existing_zone["vault"].resource_group_name,
    )
  }

  assert {
    condition = azurerm_private_dns_a_record.this["vault.key1"].private_dns_zone_id == data.azurerm_private_dns_zone.existing_zone["vault"].id
    error_message = format(
      "a record must attach to the existing zone id, got %q",
      azurerm_private_dns_a_record.this["vault.key1"].private_dns_zone_id,
    )
  }

  assert {
    condition = azurerm_private_dns_zone_virtual_network_link.this["vault-link1"].private_dns_zone_id == data.azurerm_private_dns_zone.existing_zone["vault"].id
    error_message = format(
      "virtual network link must attach to the existing zone id, got %q",
      azurerm_private_dns_zone_virtual_network_link.this["vault-link1"].private_dns_zone_id,
    )
  }
}

run "existing_zone_via_zones_flag" {
  command = plan

  variables {
    zones = {
      use_existing_zone = true

      private = {
        vault = {
          name = "privatelink.vaultcore.azure.net"

          records = {
            a = {
              key1 = {
                ttl     = 3600
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_private_dns_zone.existing_zone) == 1 && length(azurerm_private_dns_zone.this) == 0
    error_message = format(
      "zones.use_existing_zone alone must select the data source, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_private_dns_zone.existing_zone),
      length(azurerm_private_dns_zone.this),
    )
  }

  assert {
    condition = azurerm_private_dns_a_record.this["vault.key1"].private_dns_zone_id == data.azurerm_private_dns_zone.existing_zone["vault"].id
    error_message = format(
      "a record must attach to the existing zone id, got %q",
      azurerm_private_dns_a_record.this["vault.key1"].private_dns_zone_id,
    )
  }
}

run "existing_zone_via_zone_flag" {
  command = plan

  variables {
    zones = {
      private = {
        vault = {
          name              = "privatelink.vaultcore.azure.net"
          use_existing_zone = true

          records = {
            a = {
              key1 = {
                ttl     = 3600
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_private_dns_zone.existing_zone) == 1 && length(azurerm_private_dns_zone.this) == 0
    error_message = format(
      "zones.private.vault.use_existing_zone alone must select the data source, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_private_dns_zone.existing_zone),
      length(azurerm_private_dns_zone.this),
    )
  }
}

run "managed_zone_when_no_flag_set" {
  command = apply

  override_resource {
    target = azurerm_private_dns_zone.this["vault"]
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/privateDnsZones/vault-managed"
    }
  }

  variables {
    zones = {
      private = {
        vault = {
          name = "privatelink.vaultcore.azure.net"

          virtual_network_links = {
            link1 = {
              virtual_network_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-net/providers/Microsoft.Network/virtualNetworks/vnet-test"
            }
          }

          records = {
            a = {
              key1 = {
                ttl     = 3600
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_private_dns_zone.existing_zone) == 0 && length(azurerm_private_dns_zone.this) == 1
    error_message = format(
      "with no flag set the zone must be created and nothing looked up, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_private_dns_zone.existing_zone),
      length(azurerm_private_dns_zone.this),
    )
  }

  assert {
    condition = azurerm_private_dns_a_record.this["vault.key1"].private_dns_zone_id == azurerm_private_dns_zone.this["vault"].id
    error_message = format(
      "a record must attach to the created zone id, got %q",
      azurerm_private_dns_a_record.this["vault.key1"].private_dns_zone_id,
    )
  }

  assert {
    condition = azurerm_private_dns_zone_virtual_network_link.this["vault-link1"].private_dns_zone_id == azurerm_private_dns_zone.this["vault"].id
    error_message = format(
      "virtual network link must attach to the created zone id, got %q",
      azurerm_private_dns_zone_virtual_network_link.this["vault-link1"].private_dns_zone_id,
    )
  }
}
