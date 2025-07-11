data "azurerm_key_vault" "key_vault_data" {
  name                = var.key_vault_name
  resource_group_name = var.resouce_group
}


resource "azurerm_key_vault_secret" "key_secret" {
  name         = var.name_key_secret
  value        = var.secret_value
  key_vault_id = data.azurerm_key_vault.key_vault_data.id
}

#er
#new code 

#2nd new command added new try added branch