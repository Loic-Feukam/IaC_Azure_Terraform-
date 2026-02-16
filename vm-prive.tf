resource "azurerm_network_interface" "nic-prive" {
  name                = "nic-prive"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.prive.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm-prive" {
  name                = "vm-prive"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2alds_v7"
  admin_username      = "loicmeng"
  network_interface_ids = [
    azurerm_network_interface.nic-prive.id,
  ]


admin_ssh_key {
    username   = "loicmeng"
    public_key = file("~/.ssh/id_rsa-vmprive.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "debian-12"
    sku       = "12-gen2"
    version   = "latest"
  }
}