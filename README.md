# Dns Zones

This Terraform module optimizes the setup and administration of private dns zones, ensuring secure and confidential name resolution for azure services. It offers adaptable configuration options to enhance network security and streamline service connectivity.

## Features

Support the deployment of multiple private and public dns zones.

Enables the creation of multiple A, SRV, Alias, MX, and TXT records within each zone.

Utilization of terratest for robust validation.

Allows multiple virtual network links per private dns zone.

Provides support for utilizing existing private dns zones.

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (~> 1.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_dns_a_record.a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) (resource)
- [azurerm_dns_aaaa_record.aaaa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) (resource)
- [azurerm_dns_caa_record.caa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) (resource)
- [azurerm_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) (resource)
- [azurerm_dns_mx_record.mx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) (resource)
- [azurerm_dns_ns_record.ns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) (resource)
- [azurerm_dns_ptr_record.ptr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) (resource)
- [azurerm_dns_srv_record.srv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) (resource)
- [azurerm_dns_txt_record.txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) (resource)
- [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) (resource)
- [azurerm_private_dns_a_record.a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) (resource)
- [azurerm_private_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) (resource)
- [azurerm_private_dns_mx_record.mx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) (resource)
- [azurerm_private_dns_ptr_record.ptr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) (resource)
- [azurerm_private_dns_srv_record.srv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) (resource)
- [azurerm_private_dns_txt_record.txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) (resource)
- [azurerm_private_dns_zone.zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) (resource)
- [azurerm_private_dns_zone_virtual_network_link.link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) (resource)
- [azurerm_private_dns_zone.existing_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: Default resource group to be used when not specified at zone level

Type: `string`

### <a name="input_zones"></a> [zones](#input\_zones)

Description: DNS zones configuration for both public and private zones

Type:

```hcl
object({
    public = optional(map(object({
      name                = string
      resource_group_name = optional(string)
      use_existing_zone   = optional(bool, false)
      tags                = optional(map(string))
      soa_record = optional(object({
        email         = string
        ttl           = optional(number, 3600)
        expire_time   = optional(number, 2419200)
        retry_time    = optional(number, 300)
        minimum_ttl   = optional(number, 300)
        refresh_time  = optional(number, 3600)
        serial_number = optional(number, 1)
        tags          = optional(map(string))
      }))
      records = optional(object({
        a = optional(map(object({
          name               = optional(string)
          ttl                = number
          records            = list(string)
          tags               = optional(map(string))
          target_resource_id = optional(string)
        })), {})
        aaaa = optional(map(object({
          name               = optional(string)
          ttl                = number
          records            = list(string)
          tags               = optional(map(string))
          target_resource_id = optional(string)
        })), {})
        caa = optional(map(object({
          name = optional(string)
          ttl  = number
          records = list(object({
            flags = number
            tag   = string
            value = string
          }))
          tags = optional(map(string))
        })), {})
        cname = optional(map(object({
          name               = optional(string)
          ttl                = number
          record             = string
          tags               = optional(map(string))
          target_resource_id = optional(string)
        })), {})
        mx = optional(map(object({
          name = optional(string)
          ttl  = number
          records = list(object({
            preference = number
            exchange   = string
          }))
          tags = optional(map(string))
        })), {})
        ns = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        ptr = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        srv = optional(map(object({
          name = optional(string)
          ttl  = number
          records = map(object({
            priority = number
            weight   = number
            port     = number
            target   = string
          }))
          tags = optional(map(string))
        })), {})
        txt = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
      }), {})
    })), {})
    private = optional(map(object({
      name                = string
      resource_group_name = optional(string)
      use_existing_zone   = optional(bool, false)
      tags                = optional(map(string))
      virtual_network_links = optional(map(object({
        virtual_network_id   = string
        registration_enabled = optional(bool, false)
        resolution_policy    = optional(string)
        tags                 = optional(map(string))
      })))
      soa_record = optional(object({
        email        = string
        expire_time  = optional(number, 2419200)
        minimum_ttl  = optional(number, 10)
        refresh_time = optional(number, 3600)
        retry_time   = optional(number, 300)
        ttl          = optional(number, 3600)
        tags         = optional(map(string))
      }))
      records = optional(object({
        a = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        cname = optional(map(object({
          name   = optional(string)
          ttl    = number
          record = string
          tags   = optional(map(string))
        })), {})
        mx = optional(map(object({
          name = optional(string)
          ttl  = number
          records = list(object({
            preference = number
            exchange   = string
          }))
          tags = optional(map(string))
        })), {})
        ptr = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        srv = optional(map(object({
          name = optional(string)
          ttl  = number
          records = map(object({
            priority = number
            weight   = number
            port     = number
            target   = string
          }))
          tags = optional(map(string))
        })), {})
        txt = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
      }), {})
    })), {})
    use_existing_zone = optional(bool, false)
  })
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

### <a name="input_use_existing_private_dns_zone"></a> [use\_existing\_private\_dns\_zone](#input\_use\_existing\_private\_dns\_zone)

Description: whether to use existing private dns zones

Type: `bool`

Default: `false`

### <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links)

Description: Virtual network links to apply to all private DNS zones (fallback when zone-specific links are not defined)

Type:

```hcl
map(object({
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
    resolution_policy    = optional(string)
    tags                 = optional(map(string))
  }))
```

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_private_a_records"></a> [private\_a\_records](#output\_private\_a\_records)

Description: Contains all private DNS A records

### <a name="output_private_cname_records"></a> [private\_cname\_records](#output\_private\_cname\_records)

Description: Contains all private DNS CNAME records

### <a name="output_private_mx_records"></a> [private\_mx\_records](#output\_private\_mx\_records)

Description: Contains all private DNS MX records

### <a name="output_private_ptr_records"></a> [private\_ptr\_records](#output\_private\_ptr\_records)

Description: Contains all private DNS PTR records

### <a name="output_private_srv_records"></a> [private\_srv\_records](#output\_private\_srv\_records)

Description: Contains all private DNS SRV records

### <a name="output_private_txt_records"></a> [private\_txt\_records](#output\_private\_txt\_records)

Description: Contains all private DNS TXT records

### <a name="output_private_zones"></a> [private\_zones](#output\_private\_zones)

Description: Contains all private DNS zones (new and existing)

### <a name="output_public_a_records"></a> [public\_a\_records](#output\_public\_a\_records)

Description: Contains all public DNS A records

### <a name="output_public_aaaa_records"></a> [public\_aaaa\_records](#output\_public\_aaaa\_records)

Description: Contains all public DNS AAAA records

### <a name="output_public_caa_records"></a> [public\_caa\_records](#output\_public\_caa\_records)

Description: Contains all public DNS CAA records

### <a name="output_public_cname_records"></a> [public\_cname\_records](#output\_public\_cname\_records)

Description: Contains all public DNS CNAME records

### <a name="output_public_mx_records"></a> [public\_mx\_records](#output\_public\_mx\_records)

Description: Contains all public DNS MX records

### <a name="output_public_ns_records"></a> [public\_ns\_records](#output\_public\_ns\_records)

Description: Contains all public DNS NS records

### <a name="output_public_ptr_records"></a> [public\_ptr\_records](#output\_public\_ptr\_records)

Description: Contains all public DNS PTR records

### <a name="output_public_srv_records"></a> [public\_srv\_records](#output\_public\_srv\_records)

Description: Contains all public DNS SRV records

### <a name="output_public_txt_records"></a> [public\_txt\_records](#output\_public\_txt\_records)

Description: Contains all public DNS TXT records

### <a name="output_public_zones"></a> [public\_zones](#output\_public\_zones)

Description: Contains all public DNS zones

### <a name="output_virtual_network_links"></a> [virtual\_network\_links](#output\_virtual\_network\_links)

Description: Contains all private DNS zone virtual network links
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-pdns/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-pdns" />
</a>

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/dns/privatedns/operation-groups)
