resource "azurerm_mssql_database" "sqldatabase" {
  name         = var.sqldatabase_name
  server_id    = var.server_id
  # collation    = var.collation
  # license_type = var.license_type
  max_size_gb  = 2
  sku_name     = "S0"
}

