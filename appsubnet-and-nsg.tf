# Resource 1 : Create Apptier subnet
resource "azurerm_subnet" "appsubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.app_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.app_subnet_address_space
}

# Resource -2 : Create Network Security Group
resource "azurerm_network_security_group" "app_subnet_nsg" {
  name = "${azurerm_subnet.appsubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

# Resource -3 : Associate NSG and subnet
## ** # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created 
resource "azurerm_subnet_network_security_group_association" "app_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.app_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.app_subnet_nsg.id
}

# Resource 4 : Create NSG rule
##Local blocks for security
locals {
  app_inbounded_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "8080"
    "130" : "22"
  }
}


## NSG rule for Apptier subnet
resource "azurerm_network_security_rule" "app_nsg_rule_inbound" {
  for_each                     = local.app_inbounded_ports_map
  name                         =  "Rule-Port-${each.value}"
  priority                     =  each.key
  direction                    =  "Inbound"
  access                       =  "Allow"
  protocol                     =  "Tcp"
  source_port_range            =  "*"
  destination_port_range       =  each.value
  source_address_prefix        =  "*"
  destination_address_prefix   =  "*"
  resource_group_name          =  azurerm_resource_group.rg.name
  network_security_group_name  =  azurerm_network_security_group.app_subnet_nsg.name
}