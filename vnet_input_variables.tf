#Virtual network , Subnets and Subnet NSG'S
#Virtual network
variable "vnet_name" {
    description = "Virtual network name"
    type = string
    default = "vnet-default"
}
variable "vnet_address_space" {
  description = "virtual network address_space"
  type = list(string)
  default = [ "10.0.0.0/16" ]
}

#websubnet name
variable "web_subnet_name" {
  description = "Virtual network Web subnet name"
  type = string
  default = "websubnet"
}
#Web subnet address space
variable "web_subnet_address_space" {
  description = "Web subnet address space"
  type = list(string)
  default = [ "10.1.0.0/24" ]
}
#App subnet
variable "app_subnet_name" {
  description = "virtual network app subnet name"
  type = string
  default = "appsubnet"
}

#App subent address space
variable "app_subnet_address_space" {
  description = "Virtual network app subnet address space"
  type = list(string)
  default = [ "10.0.11.0/24" ]
}
#Data base subnet
variable "db_subnet_name" {
  description = "Virtual network Database subnet"
  type = string
  default = "dbsubnet"
}
#Data base subnet address space
variable "db_subnet_address_space" {
  description = "Virtual network Data base subnet address space"
  type = list(string)
  default = [ "10.0.21.0/24" ]
}
# Bastion / Management subnet name
variable "bastion_subnet_name" {
  description = "Virtual network bastion subnet name"
  type = string
  default = "bastionsubnet"
}
# Bastion / Management subnet address space
variable "bastion_subnet_address_space" {
  description = "Virtual network bastion subnet address space"
  type = list(string)
  default = [ "10.0.100.0/24" ]
}