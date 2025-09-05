#this is the temporary file


/*

*/
#hello
/**/
# daily updates start

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.43.0"
    }
  }
}

provider "azurerm" {
  #Username = "cloud_user_p_bfef1037@realhandsonlabs.com"
  #Password = "7+kn-t2@"
  Client id = "222e7fa4-e7c4-4e46-979c-6e81577e80da"
  secret id = "9en8Q~WQfoSVjkV1welQfY8iPF5XoGKQqlGTkbEI"
  subscription id = "80ea84e8-afce-4851-928a-9e2219724c69"
  tenant id = "84f1e4ea-8554-43e1-8709-f0b8589ea118"
   features {}
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  client_id       = "222e7fa4-e7c4-4e46-979c-6e81577e80da"
  client_secret   = "9en8Q~WQfoSVjkV1welQfY8iPF5XoGKQqlGTkbEI"
  subscription_id = "80ea84e8-afce-4851-928a-9e2219724c69"
  tenant_id       = "84f1e4ea-8554-43e1-8709-f0b8589ea118"
}

resource "azurerm_resource_group" "example" {
  name     = "example-rg"
  location = "westus"
}

resource "azurerm_virtual_network" "example" {
  name                = "examplevnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "example" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "exampleni"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                            = "examplevm"
  resource_group_name             = azurerm_resource_group.example.name
  location                        = azurerm_resource_group.example.location
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  admin_password                  = "P@$$w0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}


# daily updates end


/*

*/
