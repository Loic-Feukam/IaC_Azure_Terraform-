
resource "azurerm_public_ip" "pip" {
  name                = "pip-vm"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method = "Static" 
  sku               = "Standard"
}


resource "azurerm_network_interface" "nic-public" {
  name                = "nic-public"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.public.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-public" {
  name                = var.vm-public
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_D2alds_v7"
  admin_username      = var.nom
  network_interface_ids = [
    azurerm_network_interface.nic-public.id,
  ]

  admin_ssh_key {
    username   = var.nom
    public_key = file(var.ssh_key_vm_public)
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