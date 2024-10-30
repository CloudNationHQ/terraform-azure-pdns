# Private Dns Zones

This Terraform module optimizes the setup and administration of private dns zones, ensuring secure and confidential name resolution for azure services. It offers adaptable configuration options to enhance network security and streamline service connectivity.

## Goals

The main objective is to create a more logic data structure, achieved by combining and grouping related resources together in a complex object.

The structure of the module promotes reusability. It's intended to be a repeatable component, simplifying the process of building diverse workloads and platform accelerators consistently.

A primary goal is to utilize keys and values in the object that correspond to the REST API's structure. This enables us to carry out iterations, increasing its practical value as time goes on.

A last key goal is to separate logic from configuration in the module, thereby enhancing its scalability, ease of customization, and manageability.

## Non-Goals

These modules are not intended to be complete, ready-to-use solutions; they are designed as components for creating your own patterns.

They are not tailored for a single use case but are meant to be versatile and applicable to a range of scenarios.

Security standardization is applied at the pattern level, while the modules include default values based on best practices but do not enforce specific security standards.

End-to-end testing is not conducted on these modules, as they are individual components and do not undergo the extensive testing reserved for complete patterns or solutions.

## Features

- support the deployment of multiple private and public dns zones.
- enables the creation of multiple A, SRV, Alias, MX, and TXT records within each zone.
- utilization of terratest for robust validation.
- allows multiple virtual network links per private dns zone.
- provides support for utilizing existing private dns zones.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_dns_a_record.a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.aaaa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.caa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_ns_record.ns](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.ptr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.srv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_private_dns_a_record.a](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_cname_record.cname](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_mx_record.mx](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) | resource |
| [azurerm_private_dns_ptr_record.ptr](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) | resource |
| [azurerm_private_dns_srv_record.srv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) | resource |
| [azurerm_private_dns_txt_record.txt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.link](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_private_dns_zone.existing_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_predefined_private_dns_zones"></a> [predefined\_private\_dns\_zones](#input\_predefined\_private\_dns\_zones) | predefined private dns zones for azure services | <pre>map(object({<br/>    name = string<br/>  }))</pre> | <pre>{<br/>  "azure_acr_registry": {<br/>    "name": "privatelink.azurecr.io"<br/>  },<br/>  "azure_ai_cog_svcs": {<br/>    "name": "privatelink.cognitiveservices.azure.com"<br/>  },<br/>  "azure_ai_oai": {<br/>    "name": "privatelink.openai.azure.com"<br/>  },<br/>  "azure_api_management": {<br/>    "name": "privatelink.azure-api.net"<br/>  },<br/>  "azure_app_configuration": {<br/>    "name": "privatelink.azconfig.io"<br/>  },<br/>  "azure_app_service": {<br/>    "name": "privatelink.azurewebsites.net"<br/>  },<br/>  "azure_app_service_scm": {<br/>    "name": "scm.privatelink.azurewebsites.net"<br/>  },<br/>  "azure_arc_guest_configuration": {<br/>    "name": "privatelink.guestconfiguration.azure.com"<br/>  },<br/>  "azure_arc_hybrid_compute": {<br/>    "name": "privatelink.his.arc.azure.com"<br/>  },<br/>  "azure_arc_kubernetes": {<br/>    "name": "privatelink.dp.kubernetesconfiguration.azure.com"<br/>  },<br/>  "azure_attestation": {<br/>    "name": "privatelink.attest.azure.net"<br/>  },<br/>  "azure_automation": {<br/>    "name": "privatelink.azure-automation.net"<br/>  },<br/>  "azure_avd_feed_mgmt": {<br/>    "name": "privatelink.wvd.microsoft.com"<br/>  },<br/>  "azure_avd_global": {<br/>    "name": "privatelink-global.wvd.microsoft.com"<br/>  },<br/>  "azure_bot_svc_bot": {<br/>    "name": "privatelink.directline.botframework.com"<br/>  },<br/>  "azure_bot_svc_token": {<br/>    "name": "privatelink.token.botframework.com"<br/>  },<br/>  "azure_cosmos_db_analytical": {<br/>    "name": "privatelink.analytics.cosmos.azure.com"<br/>  },<br/>  "azure_cosmos_db_cassandra": {<br/>    "name": "privatelink.cassandra.cosmos.azure.com"<br/>  },<br/>  "azure_cosmos_db_gremlin": {<br/>    "name": "privatelink.gremlin.cosmos.azure.com"<br/>  },<br/>  "azure_cosmos_db_mongo": {<br/>    "name": "privatelink.mongo.cosmos.azure.com"<br/>  },<br/>  "azure_cosmos_db_postgres": {<br/>    "name": "privatelink.postgres.cosmos.azure.com"<br/>  },<br/>  "azure_cosmos_db_sql": {<br/>    "name": "privatelink.documents.azure.com"<br/>  },<br/>  "azure_cosmos_db_table": {<br/>    "name": "privatelink.table.cosmos.azure.com"<br/>  },<br/>  "azure_data_factory": {<br/>    "name": "privatelink.datafactory.azure.net"<br/>  },<br/>  "azure_data_factory_portal": {<br/>    "name": "privatelink.adf.azure.com"<br/>  },<br/>  "azure_data_lake_gen2": {<br/>    "name": "privatelink.dfs.core.windows.net"<br/>  },<br/>  "azure_databricks_ui_api": {<br/>    "name": "privatelink.azuredatabricks.net"<br/>  },<br/>  "azure_digital_twins": {<br/>    "name": "privatelink.digitaltwins.azure.net"<br/>  },<br/>  "azure_event_grid": {<br/>    "name": "privatelink.eventgrid.azure.net"<br/>  },<br/>  "azure_file_sync": {<br/>    "name": "privatelink.afs.azure.net"<br/>  },<br/>  "azure_grafana": {<br/>    "name": "privatelink.grafana.azure.com"<br/>  },<br/>  "azure_hdinsight": {<br/>    "name": "privatelink.azurehdinsight.net"<br/>  },<br/>  "azure_healthcare_dicom": {<br/>    "name": "privatelink.dicom.azurehealthcareapis.com"<br/>  },<br/>  "azure_healthcare_fhir": {<br/>    "name": "privatelink.fhir.azurehealthcareapis.com"<br/>  },<br/>  "azure_healthcare_workspaces": {<br/>    "name": "privatelink.workspace.azurehealthcareapis.com"<br/>  },<br/>  "azure_iot_central": {<br/>    "name": "privatelink.azureiotcentral.com"<br/>  },<br/>  "azure_iot_hub": {<br/>    "name": "privatelink.azure-devices.net"<br/>  },<br/>  "azure_iot_hub_provisioning": {<br/>    "name": "privatelink.azure-devices-provisioning.net"<br/>  },<br/>  "azure_iot_hub_update": {<br/>    "name": "privatelink.api.adu.microsoft.com"<br/>  },<br/>  "azure_key_vault": {<br/>    "name": "privatelink.vaultcore.azure.net"<br/>  },<br/>  "azure_log_analytics": {<br/>    "name": "privatelink.oms.opinsights.azure.com"<br/>  },<br/>  "azure_log_analytics_data": {<br/>    "name": "privatelink.ods.opinsights.azure.com"<br/>  },<br/>  "azure_managed_hsm": {<br/>    "name": "privatelink.managedhsm.azure.net"<br/>  },<br/>  "azure_maria_db_server": {<br/>    "name": "privatelink.mariadb.database.azure.com"<br/>  },<br/>  "azure_media_services_delivery": {<br/>    "name": "privatelink.media.azure.net"<br/>  },<br/>  "azure_migration_service": {<br/>    "name": "privatelink.prod.migration.windowsazure.com"<br/>  },<br/>  "azure_ml": {<br/>    "name": "privatelink.api.azureml.ms"<br/>  },<br/>  "azure_ml_notebooks": {<br/>    "name": "privatelink.notebooks.azure.net"<br/>  },<br/>  "azure_monitor": {<br/>    "name": "privatelink.monitor.azure.com"<br/>  },<br/>  "azure_monitor_agent": {<br/>    "name": "privatelink.agentsvc.azure-automation.net"<br/>  },<br/>  "azure_mysql_db_server": {<br/>    "name": "privatelink.mysql.database.azure.com"<br/>  },<br/>  "azure_postgres_sql_server": {<br/>    "name": "privatelink.postgres.database.azure.com"<br/>  },<br/>  "azure_power_bi_dedicated": {<br/>    "name": "privatelink.pbidedicated.windows.net"<br/>  },<br/>  "azure_power_bi_power_query": {<br/>    "name": "privatelink.tip1.powerquery.microsoft.com"<br/>  },<br/>  "azure_power_bi_tenant_analysis": {<br/>    "name": "privatelink.analysis.windows.net"<br/>  },<br/>  "azure_purview_account": {<br/>    "name": "privatelink.purview.azure.com"<br/>  },<br/>  "azure_purview_studio": {<br/>    "name": "privatelink.purviewstudio.azure.com"<br/>  },<br/>  "azure_redis_cache": {<br/>    "name": "privatelink.redis.cache.windows.net"<br/>  },<br/>  "azure_redis_enterprise": {<br/>    "name": "privatelink.redisenterprise.cache.azure.net"<br/>  },<br/>  "azure_search": {<br/>    "name": "privatelink.search.windows.net"<br/>  },<br/>  "azure_service_hub": {<br/>    "name": "privatelink.servicebus.windows.net"<br/>  },<br/>  "azure_signalr_service": {<br/>    "name": "privatelink.service.signalr.net"<br/>  },<br/>  "azure_site_recovery": {<br/>    "name": "privatelink.siterecovery.windowsazure.com"<br/>  },<br/>  "azure_sql_server": {<br/>    "name": "privatelink.database.windows.net"<br/>  },<br/>  "azure_static_web_apps": {<br/>    "name": "privatelink.azurestaticapps.net"<br/>  },<br/>  "azure_storage_blob": {<br/>    "name": "privatelink.blob.core.windows.net"<br/>  },<br/>  "azure_storage_file": {<br/>    "name": "privatelink.file.core.windows.net"<br/>  },<br/>  "azure_storage_queue": {<br/>    "name": "privatelink.queue.core.windows.net"<br/>  },<br/>  "azure_storage_table": {<br/>    "name": "privatelink.table.core.windows.net"<br/>  },<br/>  "azure_storage_web": {<br/>    "name": "privatelink.web.core.windows.net"<br/>  }<br/>}</pre> | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | default resource group to be used. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | tags to be added to the resources | `map(string)` | `{}` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | contains private dns zones configuration | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_zones"></a> [private\_zones](#output\_private\_zones) | Contains all private DNS zones (new, existing, and predefined) |
| <a name="output_public_zones"></a> [public\_zones](#output\_public\_zones) | Contains all public DNS zones |
<!-- END_TF_DOCS -->

## Testing

Ensure go and terraform are installed.

Run tests for different usage scenarios by specifying the EXAMPLE environment variable. Usage examples are in the examples directory.

To execute a test, run `make test EXAMPLE=default`

Replace default with the specific example you want to test. These tests ensure the module performs reliably across various configurations.

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Authors

Module is maintained by [these awesome contributors](https://github.com/cloudnationhq/terraform-azure-pdns/graphs/contributors).

## Contributing

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md).

## License

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/dns/privatedns/operation-groups)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/blob/main/specification/privatedns/resource-manager/Microsoft.Network/stable/2020-06-01/privatedns.json)
