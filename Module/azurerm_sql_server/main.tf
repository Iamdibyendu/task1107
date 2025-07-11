resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlservername
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
#   minimum_tls_version          = var.minimum_tls_version
}
