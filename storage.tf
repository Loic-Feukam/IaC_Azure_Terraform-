resource "azurerm_storage_account" "loicstockage" {
  name                     = "loicstockage"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

   network_rules {
    default_action             = "Deny"  #"Deny"
   # ip_rules                   = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.public.id]
  }
}

resource "azurerm_storage_share" "loicshare" {
  name               = "loicshare"
  storage_account_id = azurerm_storage_account.loicstockage.id
  quota              = 10
}