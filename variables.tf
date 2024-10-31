variable "zones" {
  description = "contains private dns zones configuration"
  type        = any
}

variable "predefined_private_dns_zones" {
  description = "predefined private dns zones for azure services"
  type = map(object({
    name = string
  }))
  default = {
    azure_ml = {
      name = "privatelink.api.azureml.ms"
    }
    azure_ml_notebooks = {
      name = "privatelink.notebooks.azure.net"
    }
    azure_ai_cog_svcs = {
      name = "privatelink.cognitiveservices.azure.com"
    }
    azure_ai_oai = {
      name = "privatelink.openai.azure.com"
    }
    azure_bot_svc_bot = {
      name = "privatelink.directline.botframework.com"
    }
    azure_bot_svc_token = {
      name = "privatelink.token.botframework.com"
    }
    azure_service_hub = {
      name = "privatelink.servicebus.windows.net"
    }
    azure_data_factory = {
      name = "privatelink.datafactory.azure.net"
    }
    azure_data_factory_portal = {
      name = "privatelink.adf.azure.com"
    }
    azure_hdinsight = {
      name = "privatelink.azurehdinsight.net"
    }
    azure_storage_blob = {
      name = "privatelink.blob.core.windows.net"
    }
    azure_storage_queue = {
      name = "privatelink.queue.core.windows.net"
    }
    azure_storage_table = {
      name = "privatelink.table.core.windows.net"
    }
    azure_storage_file = {
      name = "privatelink.file.core.windows.net"
    }
    azure_storage_web = {
      name = "privatelink.web.core.windows.net"
    }
    azure_data_lake_gen2 = {
      name = "privatelink.dfs.core.windows.net"
    }
    azure_file_sync = {
      name = "privatelink.afs.azure.net"
    }
    azure_power_bi_tenant_analysis = {
      name = "privatelink.analysis.windows.net"
    }
    azure_power_bi_dedicated = {
      name = "privatelink.pbidedicated.windows.net"
    }
    azure_power_bi_power_query = {
      name = "privatelink.tip1.powerquery.microsoft.com"
    }
    azure_databricks_ui_api = {
      name = "privatelink.azuredatabricks.net"
    }
    azure_avd_global = {
      name = "privatelink-global.wvd.microsoft.com"
    }
    azure_avd_feed_mgmt = {
      name = "privatelink.wvd.microsoft.com"
    }
    azure_acr_registry = {
      name = "privatelink.azurecr.io"
    }
    azure_sql_server = {
      name = "privatelink.database.windows.net"
    }
    azure_cosmos_db_sql = {
      name = "privatelink.documents.azure.com"
    }
    azure_cosmos_db_mongo = {
      name = "privatelink.mongo.cosmos.azure.com"
    }
    azure_cosmos_db_cassandra = {
      name = "privatelink.cassandra.cosmos.azure.com"
    }
    azure_cosmos_db_gremlin = {
      name = "privatelink.gremlin.cosmos.azure.com"
    }
    azure_cosmos_db_table = {
      name = "privatelink.table.cosmos.azure.com"
    }
    azure_cosmos_ddfmb_analytical = {
      name = "privatelink.analytics.cosmos.azure.com"
    }
    azure_cosmos_db_postgres = {
      name = "privatelink.postgres.cosmos.azure.com"
    }
    azure_maria_db_server = {
      name = "privatelink.mariadb.database.azure.com"
    }
    azure_postgres_sql_server = {
      name = "privatelink.postgres.database.azure.com"
    }
    azure_mysql_db_server = {
      name = "privatelink.mysql.database.azure.com"
    }
    azure_redis_cache = {
      name = "privatelink.redis.cache.windows.net"
    }
    azure_redis_enterprise = {
      name = "privatelink.redisenterprise.cache.azure.net"
    }
    azure_arc_hybrid_compute = {
      name = "privatelink.his.arc.azure.com"
    }
    azure_arc_guest_configuration = {
      name = "privatelink.guestconfiguration.azure.com"
    }
    azure_arc_kubernetes = {
      name = "privatelink.dp.kubernetesconfiguration.azure.com"
    }
    azure_event_grid = {
      name = "privatelink.eventgrid.azure.net"
    }
    azure_api_management = {
      name = "privatelink.azure-api.net"
    }
    azure_healthcare_workspaces = {
      name = "privatelink.workspace.azurehealthcareapis.com"
    }
    azure_healthcare_fhir = {
      name = "privatelink.fhir.azurehealthcareapis.com"
    }
    azure_healthcare_dicom = {
      name = "privatelink.dicom.azurehealthcareapis.com"
    }
    azure_iot_hub = {
      name = "privatelink.azure-devices.net"
    }
    azure_iot_hub_provisioning = {
      name = "privatelink.azure-devices-provisioning.net"
    }
    azure_iot_hub_update = {
      name = "privatelink.api.adu.microsoft.com"
    }
    azure_iot_central = {
      name = "privatelink.azureiotcentral.com"
    }
    azure_digital_twins = {
      name = "privatelink.digitaltwins.azure.net"
    }
    azure_media_services_delivery = {
      name = "privatelink.media.azure.net"
    }
    azure_automation = {
      name = "privatelink.azure-automation.net"
    }
    azure_site_recovery = {
      name = "privatelink.siterecovery.windowsazure.com"
    }
    azure_monitor = {
      name = "privatelink.monitor.azure.com"
    }
    azure_log_analytics = {
      name = "privatelink.oms.opinsights.azure.com"
    }
    azure_log_analytics_data = {
      name = "privatelink.ods.opinsights.azure.com"
    }
    azure_monitor_agent = {
      name = "privatelink.agentsvc.azure-automation.net"
    }
    azure_purview_account = {
      name = "privatelink.purview.azure.com"
    }
    azure_purview_studio = {
      name = "privatelink.purviewstudio.azure.com"
    }
    azure_migration_service = {
      name = "privatelink.prod.migration.windowsazure.com"
    }
    azure_grafana = {
      name = "privatelink.grafana.azure.com"
    }
    azure_key_vault = {
      name = "privatelink.vaultcore.azure.net"
    }
    azure_managed_hsm = {
      name = "privatelink.managedhsm.azure.net"
    }
    azure_app_configuration = {
      name = "privatelink.azconfig.io"
    }
    azure_attestation = {
      name = "privatelink.attest.azure.net"
    }
    azure_search = {
      name = "privatelink.search.windows.net"
    }
    azure_app_service = {
      name = "privatelink.azurewebsites.net"
    }
    azure_app_service_scm = {
      name = "scm.privatelink.azurewebsites.net"
    }
    azure_signalr_service = {
      name = "privatelink.service.signalr.net"
    }
    azure_static_web_apps = {
      name = "privatelink.azurestaticapps.net"
    }
  }
}

variable "resource_group" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
