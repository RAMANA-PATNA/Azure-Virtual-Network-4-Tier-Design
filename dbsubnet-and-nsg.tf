# Resource -1 Create DBTier subnet
resource "azurerm_subnet" "dbsubnet" {
  name = "${azurerm_virtual_network.vnet.name}-${var.db_subnet_name}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.db_subnet_address_space
}

# Resource 2 : Create Network Security Group
resource "azurerm_network_security_group" "db_subnet_nsg" {
  name = "${azurerm_subnet.dbsubnet.name}-nsg"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Resource 3: Associate NSG and subnet
resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.db_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.appsubnet.id
  network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
}

## Resource 4 : Create NSG rule
## Create locals for security rules
locals {
  db_inbounded_ports_map = {
    "100" : "3306"
    "110" : "1433"
    "120" : "5432"
  }
}

## Nsg Inbounde rule for DBtier Subnets
resource "azurerm_network_security_rule" "db_nsg_rule_inbound" {
  for_each                      =  local.db_inbounded_ports_map
  name                          =  "Rule_port-${each.value}"
  priority                      =  each.key
  direction                     =  "Inbound"
  protocol                      =  "Tcp"
  source_port_range             =  "*"
  access                        =  "Allow"
  destination_port_range       =  each.value
  source_address_prefix         =  "*"
  destination_address_prefix    = "*" 
  resource_group_name           =  azurerm_resource_group.rg.name
  network_security_group_name   =  azurerm_network_security_group.db_subnet_nsg.name
}