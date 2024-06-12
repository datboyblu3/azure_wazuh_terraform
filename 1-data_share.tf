data "azurerm_data_share_account" "example" {
  name                = "example-account"
  resource_group_name = "example-resource-group"
}

data "azurerm_data_share" "example" {
  name       = "existing"
  account_id = data.azurerm_data_share_account.example.id
}

output "id" {
  value = data.azurerm_data_share.example.id
}