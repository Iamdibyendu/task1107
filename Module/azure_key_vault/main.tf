
data "azurerm_client_config" "nasa_client" {}

resource "azurerm_key_vault" "nasa_keyv" {
  name                        = var.key_vault_name
  location                    = var.location
  resource_group_name         = var.resouce_group
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.nasa_client.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.nasa_client.tenant_id
    object_id = data.azurerm_client_config.nasa_client.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get","Set","List"
    ]

    storage_permissions = [
      "Get",
    ]
  }
}