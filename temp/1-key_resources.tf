######################################################################################
# Creates Private and Public keys for each Wazuh Component
######################################################################################


#Wazuh Indexer Key Pair Creation
resource "tls_private_key" "indexer_key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "azurerm_ssh_public_key" "az-key-indexer" {
    key_name = "az_key_indexer"
    public_key = tls_private_key.indexer_key.public_key_openssh

    provisioner "local-exec"{
        command = "echo '$(tls_private_key.indexer_key.private_key_pem)' > ./az_key_indexer.pem && openssl rsa -in az_key_indexer.pem -pubout > az_key_indexer.pem.pub"
    }
}

#Wazuh Server Key Pair Creation
resource "tls_private_key" "server-key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "azurerm_ssh_public_key" "az-key-server" {
    key_name = "az_key_server"
    public_key = tls_private_key.server_key.public_key_openssh

    provisioner "local-exec"{
        command = "echo '$(tls_private_key.server_key.private_key_pem)' > ./az_key_server.pem && openssl rsa -in az_key_server.pem -pubout > az_key_server.pem.pub"
    }
}

#Wazuh Dashboard Key Pair Creation
resource "tls_private_key" "dashboard-key" {
  algorithm   = "ECDSA"
  ecdsa_curve = "P384"
}

resource "azurerm_ssh_public_key" "az-key-dashboard" {
    key_name = "az_key_dashboard"
    public_key = tls_private_key.dashboard_key.public_key_openssh

    provisioner "local-exec"{
        command = "echo '$(tls_private_key.dashboard_key.private_key_pem)' > ./az_key_dashboard.pem && openssl rsa -in az_key_dashboard.pem -pubout > az_key_dashboard.pem.pub"
    }
}
