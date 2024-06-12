######################################################################################
# Creates the Specific Compute Instances
######################################################################################

resource "azurerm_linux_virtual_machine" "az-indexer" {
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
    source = "
    destination = ""

    connection {
        
    }
  }

}
