data "azurerm_subnet" "frontend_subnet" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# data "azurerm_subnet" "backenend_subnet" {
#   name                 = var.backend_subnet_name
#   virtual_network_name = var.virtual_network_name
#   resource_group_name  = var.resource_group_name
# }


data "azurerm_public_ip" "frontend_pip" {
  name                = var.frontend_pip_name
  resource_group_name = var.resource_group_name
}

# data "azurerm_public_ip" "backend_pip" {
#   name                = var.backend_pip_name
#   resource_group_name = var.resource_group_name
# }


resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  data.azurerm_subnet.frontend_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.frontend_pip.id
  }

}

data "azurerm_key_vault" "key_vault" {
  name                = var.key_vault_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "secretuid" {
  name         = var.secretuid
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "secretpw" {
  name         = var.secretpw
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

  resource "azurerm_linux_virtual_machine" "dibyovm" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = data.azurerm_key_vault_secret.secretuid.value
  admin_password      = data.azurerm_key_vault_secret.secretpw.value
  disable_password_authentication = false 
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  # admin_ssh_key {
  #   username   = "adminuser"
  #   public_key = file("~/.ssh/id_rsa.pub")
  # }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.Image_version
  }
  }

  