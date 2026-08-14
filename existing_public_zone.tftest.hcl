mock_provider "azurerm" {
  mock_data "azurerm_dns_zone" {
    defaults = {
      id           = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-zones/providers/Microsoft.Network/dnszones/example.com"
      name_servers = ["ns1-mock.azure-dns.com."]
    }
  }
  mock_resource "azurerm_dns_zone" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/dnszones/mock-managed"
    }
  }
  mock_resource "azurerm_dns_a_record" {
    defaults = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/dnszones/mock/A/mock"
    }
  }
}

variables {
  resource_group_name = "rg-fallback"
}

run "existing_public_zone_via_global_flag" {
  command = plan

  variables {
    use_existing_public_dns_zone = true

    zones = {
      public = {
        example = {
          name                = "example.com"
          resource_group_name = "rg-zones"

          records = {
            a = {
              base = {
                ttl     = 300
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_dns_zone.this) == 1 && length(azurerm_dns_zone.this) == 0
    error_message = format(
      "the global flag must select the data source, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_dns_zone.this),
      length(azurerm_dns_zone.this),
    )
  }

  assert {
    condition = data.azurerm_dns_zone.this["example"].resource_group_name == "rg-zones"
    error_message = format(
      "existing zone must be looked up in zones.public.example.resource_group_name (\"rg-zones\"), got %q",
      data.azurerm_dns_zone.this["example"].resource_group_name,
    )
  }

  assert {
    condition = azurerm_dns_a_record.this["example.base"].zone_name == data.azurerm_dns_zone.this["example"].name
    error_message = format(
      "a record must attach to the existing zone, got zone_name %q",
      azurerm_dns_a_record.this["example.base"].zone_name,
    )
  }
}

run "existing_public_zone_via_zones_flag" {
  command = plan

  variables {
    zones = {
      use_existing_zone = true

      public = {
        example = {
          name = "example.com"

          records = {
            a = {
              base = {
                ttl     = 300
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_dns_zone.this) == 1 && length(azurerm_dns_zone.this) == 0
    error_message = format(
      "zones.use_existing_zone alone must select the data source, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_dns_zone.this),
      length(azurerm_dns_zone.this),
    )
  }

  assert {
    condition = azurerm_dns_a_record.this["example.base"].zone_name == data.azurerm_dns_zone.this["example"].name
    error_message = format(
      "a record must attach to the existing zone, got zone_name %q",
      azurerm_dns_a_record.this["example.base"].zone_name,
    )
  }
}

run "existing_public_zone_via_zone_flag" {
  command = plan

  variables {
    zones = {
      public = {
        example = {
          name              = "example.com"
          use_existing_zone = true

          records = {
            a = {
              base = {
                ttl     = 300
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_dns_zone.this) == 1 && length(azurerm_dns_zone.this) == 0
    error_message = format(
      "zones.public.example.use_existing_zone alone must select the data source, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_dns_zone.this),
      length(azurerm_dns_zone.this),
    )
  }
}

run "managed_public_zone_when_no_flag_set" {
  command = apply

  override_resource {
    target = azurerm_dns_zone.this["example"]
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/rg-fallback/providers/Microsoft.Network/dnszones/example-managed"
    }
  }

  variables {
    zones = {
      public = {
        example = {
          name = "example.com"

          records = {
            a = {
              base = {
                ttl     = 300
                records = ["10.0.0.5"]
              }
            }
          }
        }
      }
    }
  }

  assert {
    condition = length(data.azurerm_dns_zone.this) == 0 && length(azurerm_dns_zone.this) == 1
    error_message = format(
      "with no flag set the zone must be created and nothing looked up, got %d data source instance(s) and %d managed zone(s)",
      length(data.azurerm_dns_zone.this),
      length(azurerm_dns_zone.this),
    )
  }

  assert {
    condition = azurerm_dns_a_record.this["example.base"].zone_name == azurerm_dns_zone.this["example"].name
    error_message = format(
      "a record must attach to the created zone, got zone_name %q",
      azurerm_dns_a_record.this["example.base"].zone_name,
    )
  }
}
