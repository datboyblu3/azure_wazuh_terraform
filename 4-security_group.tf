######################################################################################
# Manages a network security group(s) that contains a list of network security rules.
# Network security groups enable inbound or outbound traffic to be enabled or denied.
# This will be created as a separate resource due to ease of maintenance.
######################################################################################

resource "azurerm_network_security_group" "az-wazuh-sg" {
  name     = "az-wazuh-sg"
  location = azurerm_resource_group.az-wazuh-grp.location
  resource_group_name = azurerm_resource_group.az-wazuh-grp.name

  tags = {
    environment = "dev"
  }
}

resource "azurerm_network_security_rule" "az-wazuh-rule" {
  name                        = "az-wazuh-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*" #CHANGE TO YOUR PUBLIC IP ADDRESS EX: 192.168.1.25/32
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az-wazuh-grp.name
  network_security_group_name = azurerm_network_security_group.az-wazuh-sg.name
}

resource "azurerm_subnet_network_security_group_association" "az-wazuh-sga" {
  subnet_id                 = azurerm_subnet.az-subnet.id
  network_security_group_id = azurerm_network_security_group.az-wazuh-sg.id
}