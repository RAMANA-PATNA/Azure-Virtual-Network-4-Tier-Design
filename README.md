Azure Virual Network Design

• We are design the 4-Tier Azure Virtual Network 
1.Azure Virtual Network
2.WebTier Subnet + Web Tier Network Security Group  (Ports 80, 443)
3.AppTier Subnet + App Tier Network Securoty Group (Ports 8080, 80, 443)
4.DBtier Subnet + DBTier Network Security Group (Ports 3306, 1433, 5432)
5.Baston Subnet + Baston Network Security Group (Ports 80, 3389)
6.Terraform for_each metadata. 

Azure Resources Created : 

1.azurerm_resource_group
2.azurerm_virtual_network
3.azurerm_subnet
4.azurerm_network_security_group
5.azurerm_subnet_network_security_group_association
6.azurerm_network_security_rule

Terraform concepts covered : 

1.Terraform setting block
2.Terraform provider block
3.Terraform input variables
4.Terraform local variables block
5.Terraform random resource random_string
6.Terraform for_each metadata
7.Terraform depends_on metadata
8.Terraform output values



