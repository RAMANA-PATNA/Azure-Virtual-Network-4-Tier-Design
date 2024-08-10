# Generic input variables
# Business Devision
variable "business_devision" {
    description = "Business devision is the large organization this infrastacure belongs"
    type = string
    default = "sap"
}
#Envirnoment variable
variable "envirnoment" {
  description = "Envirnoment variable is used as prefix"
  type = string
  default = "dev"
}
#Azure resource_group name
variable "resource_group_name" {
  description = "Resource Group name"
  type = string
  default = "rg-default"
}
# Resource group location
variable "resource_group_location" {
  description = "Region in which Azure resource to be created"
  type = string
  default = "eastus"
}
