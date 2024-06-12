######################################################################################
# Create a Network for Wazuh to Operate In the Selecte Resource Group.
# This will also create a Subnet into the Virtual Network.
# The subnet will be deployed separately from the Virtual Network for ease of 
# maintenance.
######################################################################################

resource "azurerm_resource_group" "az-wazuh-grp" {
  name     = "az-wazuh-resources"
  location = "East US"
  tags ={
    environment = "dev" #indiciates what environment your resources are deployed to
  }
}

resource "azurerm_virtual_network" "az-wazuh-vn" {
    name = "az-wazuh-network"
    resource_group_name = azurerm_resource_group.az-wazuh-grp.name
    location = azurerm_resource_group.az-wazuh-grp.location
    address_space = ["10.123.0.0/16"]

    tags = {
        environment = "dev"
    }
}

resource "azurerm_subnet" "az-subnet" {
    name = "az-subnet-1"
    resource_group_name = azurerm_resource_group.az-grp.name
    virtual_network_name = azurerm_virtual_network.az-wazuh-vn.name
    address_prefixes = ["10.123.1.0/24"]
}

resource "azurerm_public_ip" "az-pub-ip" {
  name                = "az-pub-ip"
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name
  location            = azurerm_resource_group.az-wazuh-grp.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_interface" "az-wazuh-nic" {
  name = "az-wazuh-nic"
  location = azurerm_resource_group.az-wazuh-grp.location
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address = "azurerm_public_ip.az-pub-ip.id
  }

  tags = {
    environment = "dev"
  }
}