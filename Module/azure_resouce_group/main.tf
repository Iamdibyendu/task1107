resource "azurerm_resource_group" "rg-auto" {
  name =  var.resource_group_name
  location = var.resource_group_location
}