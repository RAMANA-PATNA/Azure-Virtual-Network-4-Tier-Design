# Resource-1 Create webtier Subnet
resource "azurerm_subnet" "websubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.web_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.web_subnet_address_space
}

# Resource-2 Create network securoty group 
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name = "${azurerm_subnet.websubnet.name}-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}
# Resource-3 associate NSG and Subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_association" {
  # Every NSG Rule Association will disassociate NSG from Subnet and Associate it, so we associate it only after NSG is completely created  
  depends_on = [ azurerm_network_security_rule.web_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.websubnet.id
  network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

# Resource-4 Create NSG rule
## Locals block for security rules
locals {
  web_nsg_rule_inbounded = {
    "100" : "80"  # If the key starts with the number, you must use the ":" instead of "="
    "110" : "443"
    "120" : "22"
  }
}

## NSG inbounded Rule for webtier subnet
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each                     =   local.web_nsg_rule_inbounded
  name                         =   "Rule-port-${each.value}"
  priority                     =   each.key
  direction                    =   "Inbound"
  access                       =  "Allow"
  protocol                     =  "Tcp"
  source_port_range            =  "*"
  destination_port_range       =  each.value
  source_address_prefix        =  "*"
  destination_address_prefix   =  "*"
  resource_group_name          =  azurerm_resource_group.rg.name
  network_security_group_name  =  azurerm_network_security_group.web_subnet_nsg.name
}