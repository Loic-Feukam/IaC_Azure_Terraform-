
resource "azurerm_network_security_group" "public" {
  name                = "public_subnet"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

 # security_rule {
#    name                       = "ssh-out"
#    priority                   = 100
#    direction                  = "Outbound"
#    access                     = "Allow"
#    protocol                   = "Tcp"
#    source_port_range          = "22"
#    destination_port_range     = "22"
#    source_address_prefix      = "10.0.1.0/24"
#    destination_address_prefix = "10.0.2.0/24" 
#   }

}

resource "azurerm_subnet_network_security_group_association" "public" {
  subnet_id                 = azurerm_subnet.public.id
  network_security_group_id = azurerm_network_security_group.public.id
} 