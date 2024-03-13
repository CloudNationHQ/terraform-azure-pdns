locals {
  zones = {
    vault = {
      name = "privatelink.vaultcore.azure.net"
    },
    sql = {
      name = "privatelink.database.windows.net"
    },
    storage = {
      name = "privatelink.blob.core.windows.net"
    },
  }
}
