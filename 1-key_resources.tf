######################################################################################
# Creates Private and Public keys for each Wazuh Component
######################################################################################


#Wazuh Indexer Key Pair Creation
resource "tls_private_key" "indexer_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "az_key_indexer" {
  name                = "az_key_indexer"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  public_key          = tls_private_key.indexer_key.public_key_openssh
  location            = azurerm_resource_group.az-wazuh-grp.location
  provisioner "local-exec" {
    command = "echo '$(tls_private_key.indexer_key.private_key_pem)' > ./az_key_indexer.pem && openssl rsa -in az_key_indexer.pem -pubout > az_key_indexer.pem.pub"
  }
}

#Wazuh Server Key Pair Creation
resource "tls_private_key" "server_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "az_key_server" {
  name                = "az_key_server"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  public_key          = tls_private_key.server_key.public_key_openssh
  location            = azurerm_resource_group.az-wazuh-grp.location
  provisioner "local-exec" {
    command = "echo '$(tls_private_key.server_key.private_key_pem)' > ./az_key_server.pem && openssl rsa -in az_key_server.pem -pubout > az_key_server.pem.pub"
  }
}

#Wazuh Dashboard Key Pair Creation
resource "tls_private_key" "dashboard_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_ssh_public_key" "az_key_dashboard" {
  name                = "az_key_dashboard"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  public_key          = tls_private_key.dashboard_key.public_key_openssh
  location            = azurerm_resource_group.az-wazuh-grp.location
  provisioner "local-exec" {
    command = "echo '$(tls_private_key.dashboard_key.private_key_pem)' > ./az_key_dashboard.pem && openssl rsa -in az_key_dashboard.pem -pubout > az_key_dashboard.pem.pub"
  }
}
