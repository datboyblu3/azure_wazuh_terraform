######################################################################################
######################################################################################
# Creates the Specific Compute Instances
######################################################################################
######################################################################################

# Access Azure Key Vault
data "azurerm_key_vault" "kv" {
  name                = "kv-dev-mgmt"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
}

# Get Existing Key
data "azurerm_key_vault_secret" "ssh_keys" {
  name         = "az-ssh-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}


####################################################################
# Wazuh Indexer Compute Instance
####################################################################
resource "azurerm_linux_virtual_machine" "az-indexer_1" {
  name                = "wazuh-indexer"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  location            = azurerm_resource_group.az-wazuh-grp.location
  size                = "Standard_B1s"
  admin_username      = "indexer"
  network_interface_ids = [
    azurerm_network_interface.az-wazuh-nic.id
  ]

  # Get a list of secrets in the key vault
  /*data "azurerm_key_vault_secret" "ssh_key" {
    for_each     = toset(data.azurerm_key_vault_secrets.ssh_key.names)
    name         = each.key
    key_vault_id = data.azurerm_key_vault.existing.id

  }*/

  admin_ssh_key {
    username   = "datboyblu3"                                          
    public_key = data.azurerm_key_vault_secrets.ssh_keys.public_key_openssh
  }

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

  tags = {
    environment = "dev"
  }
}


####################################################################
# Wazuh Server Compute Instance
####################################################################
resource "azurerm_linux_virtual_machine" "az-server_1" {
  name                = "wazuh-server"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  location            = azurerm_resource_group.az-wazuh-grp.location
  size                = "Standard_B1s"
  admin_username      = "server" #CHANGEME
  network_interface_ids = [
    azurerm_network_interface.az-wazuh-nic.id
  ]

  # Get a list of secrets in the key vault
  /*data "azurerm_key_vault_secret" "ssh_key" {
    for_each     = toset(data.azurerm_key_vault_secrets.ssh_key.names)
    name         = each.key
    key_vault_id = data.azurerm_key_vault.existing.id

  }*/

  admin_ssh_key {
    username   = "datboyblu3"
    public_key = data.azurerm_key_vault_secrets.ssh_keys.public_key_openssh #PULL INDEX KEY FROM AZURE KEY VAULT
  }

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

  tags = {
    environment = "dev"
  }

  /*provisioner "file" {
    source = "ANSIBLE SERVER INSTALL SCRIPT"
    destination = "DESTINATION LOCATION FOR SERVER INSTALL SCRIPT"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }*/
}


####################################################################
# Wazuh Dashboard Compute Instance
####################################################################
resource "azurerm_linux_virtual_machine" "az-dashboard_1" {
  name                = "wazuh-dashboard"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  location            = azurerm_resource_group.az-wazuh-grp.location
  size                = "Standard_B1s"
  admin_username      = "dash" #CHANGEME
  network_interface_ids = [
    azurerm_network_interface.az-wazuh-nic.id
  ]

  # Get a list of secrets in the key vault
  /*data "azurerm_key_vault_secret" "ssh_key" {
    for_each     = toset(data.azurerm_key_vault_secrets.ssh_key.names)
    name         = each.key
    key_vault_id = data.azurerm_key_vault.existing.id

  }*/

  admin_ssh_key {
    username   = "datboyblu3"
    public_key = data.azurerm_key_vault_secrets.ssh_keys.public_key_openssh #PULL INDEX KEY FROM AZURE KEY VAULT
  }

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

  tags = {
    environment = "dev"
  }

  /*provisioner "file" {
    source = "ANSIBLE DASHBOARD INSTALL SCRIPT"
    destination = "DESTINATION LOCATION FOR DASHBOARD INSTALL SCRIPT"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }*/
}