# Resource 1 Create Bastion / Management subnet
resource "azurerm_subnet" "bastion_subnet" {
    name = "${azurerm_virtual_network.vnet.name}-${var.bastion_subnet_name}"
    resource_group_name = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = var.bastion_subnet_address_space
}

# Resource 2 Create Network Security Group 
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name = "${azurerm_subnet.bastion_subnet.name}-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

#Resource 3 : Associate NSG ans Subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.bastion_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.bastion_subnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}

# Resource 4 Create NSR rule
## Create Local blocks for security rules
locals {
  bastion_inbounded_ports_maps = {
    "100" : "22"
    "110" : "3389"
  }
}

# Create NSG rule
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each                     = local.bastion_inbounded_ports_maps
  name                         = "Rule-ports-${each.value}"
  access                       = "Allow"
  priority                     = each.key
  protocol                     = "Tcp"
  direction                    = "Inbound"
  source_port_range            = "*"
  destination_port_range       = each.value
  source_address_prefix        = "*"
  destination_address_prefix   = "*"
  resource_group_name          = azurerm_resource_group.rg.name
  network_security_group_name  = azurerm_network_security_group.bastion_subnet_nsg.name
}