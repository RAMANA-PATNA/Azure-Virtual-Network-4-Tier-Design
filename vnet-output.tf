# Virtual network outputs
## Virtual network name 
output "virtual_network_name" {
  description = "Virtual Network Name"
  value = azurerm_virtual_network.vnet.name
}

## Virtual Network Id
output "virtual_network_id" {
  description = "Virtual Network Id"
  value = azurerm_virtual_network.vnet.id
}

# Subnet outputs (We will write one web subnet and rest all we will ignore for now)
## Subnet Name
output "web_subnet_name" {
  description = "Subnet Name"
  value = azurerm_subnet.websubnet.name
}
## Subnet Id
output "subnet_id" {
  description = "Subnet Id"
  value = azurerm_subnet.websubnet.id
}

## Network Security Outputs
# Web subnet Name
output "web_subnet_nsg_name" {
  description = "Web subnet Network Security Name"
  value = azurerm_network_security_group.web_subnet_nsg.name
}

#Web subnet id
output "web_subnet_nsg_id" {
  description = "web Subnet Network security group id"
  value = azurerm_network_security_group.web_subnet_nsg.id
}


