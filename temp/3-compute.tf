######################################################################################
######################################################################################
# Creates the Specific Compute Instances
######################################################################################
######################################################################################



####################################################################
# Wazuh Indexer Compute Instance
####################################################################
resource "azurerm_linux_virtual_machine" "az-indexer_1" {
  name                = "wazuh-indexer"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  location            = azurerm_resource_group.az-wazuh-grp.location
  size                = "Standard_B1s"
  admin_username      = "adminuser" #CHANGEME
  network_interface_ids = [
    azurerm_network_interface.az-wazuh-nic.id
  ]

  admin_ssh_key {
    username   = "adminuser" #CHANGEME
    public_key = file("~/.ssh/id_rsa.pub") #CHANGEME
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


  provisioner "file" {
    source = "ANSIBLE INDEXER INSTALL SCRIPT"
    destination = "DESTINATION LOCATION FOR INDEXER INSTALL SCRIPT"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }


  #indexer.pem
   provisioner "file" {
    source = "AZURE INDEXER PEM FILE"
    destination = "DESTINATION LOCATION FOR AZURE INDEXER PEM FILE"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }

#indexer.pem.pub
   provisioner "file" {
    source = "AZURE INDEXER PUB FILE"
    destination = "DESTINATION LOCATION FOR AZURE INDEXER PUB FILE"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem
    }
  }


  #dashboard.pem
   provisioner "file" {
    source = "AZURE INDEXER PEM FILE"
    destination = "DESTINATION LOCATION FOR AZURE INDEXER PEM FILE"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }

    #dashboard.pem.pub
   provisioner "file" {
    source = "AZURE DASHBOARD PUB FILE"
    destination = "DESTINATION LOCATION FOR AZURE DASHBOARD PUB FILE"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem
    }
  }


  #server.pem
   provisioner "file" {
    source = "AZURE SERVER PEM FILE"
    destination = "DESTINATION LOCATION FOR AZURE SERVER PEM FILE"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem

    }
  }

    #server.pem.pub
   provisioner "file" {
    source = "AZURE SERVER PUB FILE"
    destination = "DESTINATION LOCATION FOR AZURE SERVER PUB FILE"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem
    }
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
  admin_username      = "adminuser" #CHANGEME
  network_interface_ids = [
    azurerm_network_interface.az-wazuh-nic.id
  ]

  admin_ssh_key {
    username   = "adminuser" #CHANGEME
    public_key = file("~/.ssh/id_rsa.pub") #CHANGEME
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

  provisioner "file" {
    source = "ANSIBLE SERVER INSTALL SCRIPT"
    destination = "DESTINATION LOCATION FOR SERVER INSTALL SCRIPT"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }
}


####################################################################
# Wazuh Dashboard Compute Instance
####################################################################
resource "azurerm_linux_virtual_machine" "az-dashboard_1" {
  name                = "wazuh-dashboard"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  location            = azurerm_resource_group.az-wazuh-grp.location
  size                = "Standard_B1s"
  admin_username      = "adminuser" #CHANGEME
  network_interface_ids = [
    azurerm_network_interface.az-wazuh-nic.id
  ]

  admin_ssh_key {
    username   = "adminuser" #CHANGEME
    public_key = file("~/.ssh/id_rsa.pub") #CHANGEME
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

  provisioner "file" {
    source = "ANSIBLE DASHBOARD INSTALL SCRIPT"
    destination = "DESTINATION LOCATION FOR DASHBOARD INSTALL SCRIPT"

    connection {
        host        = coalesce()
        agent       = true 
        type        = "ssh"
        user        = "adminuser"
        private_key = tls_private_key.indexer_key.private_key_pem


    }
  }
}
