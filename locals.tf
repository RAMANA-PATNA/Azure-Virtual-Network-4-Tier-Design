# Define local variables in Terraform
locals {
  owners = var.business_devision
  envirnoment = var.envirnoment
  resource_name_prefix = "${var.business_devision}-${var.envirnoment}"
  #name = "${locals.business_devision}-${locals.envirnoment}"
  common_tags = {
    owners = local.owners
    envirnoment = local.envirnoment
  }
}