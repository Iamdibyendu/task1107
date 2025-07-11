module "resouce_group" {
  source = "../module/azure_resouce_group"
  resource_group_name = "rgtodoapp"
  resource_group_location = "centralindia"
}

module "virtual_network" {
    depends_on = [ module.resouce_group ]
  source = "../module/azure_virtual_network"
  virtual_network_name = "todovn"
  virtual_network_location = "centralindia"
  resource_group_name = "rgtodoapp"
  address_space = ["10.0.0.0/16"]
}

module "frntend_subnet" {
    depends_on = [ module.virtual_network]
  source = "../module/azure_subnet"
  virtual_network_name = "todovn"
  subnet_name = "frontend_subnet"
  resource_group_name = "rgtodoapp"
  address_prefixes = ["10.0.1.0/24"]
}

module "public_ip_fe" {
  depends_on = [ module.resouce_group ]
  source = "../module/azure_public_ip"
  name = "todopublicip"
  resource_group_location = "centralindia"
  resource_group_name = "rgtodoapp"
  allocation_method = "Static"
}

module "frontend_vm_dibyo" {
depends_on = [ module.frntend_subnet, module.public_ip_fe ]
source = "../Module/azure_virtual_machhine"
 resource_group_name = "rgtodoapp"
 name = "Dfrontendvm"
 location = "centralindia"
 vm_size = "Standard_B1s"
 secretuid = "amarvmernam"
 secretpw = "amarvmerpassword"
 key_vault_name = "dlock"
 image_publisher = "Canonical"
 offer = "0001-com-ubuntu-server-focal"
 sku = "20_04-lts"
 Image_version = "latest"
 nic_name = "nic-vm-frontend"
 virtual_network_name = "todovn"
 frontend_subnet_name = "frontend_subnet"
 frontend_pip_name = "todopublicip"
}

module "db_key-vault" {
  source = "../Module/azure_key_vault"
  key_vault_name = "dlock"
  location = "centralindia"
  resouce_group = "rgtodoapp"
}

module "key_secret" {
  depends_on = [ module.db_key-vault ]
  source = "../Module/azure_key_secret"
  key_vault_name = "dlock"
  resouce_group = "rgtodoapp"
  secret_value = "dibyenduvm"
  name_key_secret = "amarvmernam"
}

module "key_secret1" {
  depends_on = [ module.db_key-vault ]
  source = "../Module/azure_key_secret"
  key_vault_name = "dlock"
  resouce_group = "rgtodoapp"
  secret_value = "dib@123"
  name_key_secret = "amarvmerpassword"
}

# module "key_secret1" {
#    depends_on = [ module.db_key-vault ]
#   source = "../Module/azure_key_secret"
#   keyvault_name = "bhbpk"
#   resouce_group = "rgtodoapp"
#   name_key_secret = "dibadmin-username"
#   secret_value = "Dibyendu@123"
# }





# module "sql_server" {
 
#  source = "../Module/azurerm_sql_server"
#  sqlservername ="tdodsqlserverdibyo"
#  resource_group_name = "rgtodoapp"
#  location = "centralindia"
#  sql_version = "12.0"
#  administrator_login ="dibyosqladmin"
#  administrator_login_password= "Dibyendu@123"
# }

# module "sql_database" {
#   depends_on = [ module.sql_server ]
#   source = "../Module/azurerm_sql_database"
#   sqldatabase_name = "dibyosqldatabase"
#   server_id = "/subscriptions/68091150-801e-4498-8be2-e5d4bcf9919c/resourceGroups/rgtodoapp/providers/Microsoft.Sql/servers/tdodsqlserverdibyo"
# }



