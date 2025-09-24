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

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

### <a name="input_use_existing_private_dns_zone"></a> [use\_existing\_private\_dns\_zone](#input\_use\_existing\_private\_dns\_zone)

Description: whether to use existing private dns zones

### <a name="input_virtual_network_links"></a> [virtual\_network\_links](#input\_virtual\_network\_links)

Description: Virtual network links to apply to all private DNS zones (fallback when zone-specific links are not defined)

### <a name="input_zones"></a> [zones](#input\_zones)

Description: DNS zones configuration for both public and private zones

## Outputs

The following outputs are exported:

### <a name="output_private_zones"></a> [private\_zones](#output\_private\_zones)

Description: Contains all private DNS zones (new and existing)

### <a name="output_public_zones"></a> [public\_zones](#output\_public\_zones)

Description: Contains all public DNS zones
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
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/privatedns/resource-manager/Microsoft.Network/stable/2020-06-01/privatedns.json)

