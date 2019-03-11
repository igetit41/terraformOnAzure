#Passed in credentials
data "external" "connectionVars" {
  program = ["sh", "connectionVars.sh" ]
}
variable "ARM_CLIENT_SECRET" {}
variable "ARM_TENANT_ID" {}

#Passed in subscription id number 1
variable "subscription_id01" {}

# The default provider configuration for default subscription
provider "azurerm" {
  alias  = "ct-terraform01"
  subscription_id = "${var.subscription_id01}"
  client_id       = "${data.external.connectionVars.result.ARM_CLIENT_ID}"
  client_secret   = "${data.external.connectionVars.result.ARM_CLIENT_SECRET}"
  tenant_id       = "${data.external.connectionVars.result.ARM_TENANT_ID}"
}

#Call environment module for subscription number 1
module "ct-terraform01-module" {
  source    = "./subscriptionConfigs"
  providers = {
    azurerm = "azurerm.ct-terraform01"
  }
  prefix = "ct-terraform01"
  region = "westus2"
}










#Passed in subscription id number 2
variable "subscription_id02" {}

# Additional provider configuration for second subscription
provider "azurerm" {
  alias  = "ct-terraform02"
  subscription_id = "${var.subscription_id02}"
  client_id       = "${data.external.connectionVars.result.ARM_CLIENT_ID}"
  client_secret   = "${data.external.connectionVars.result.ARM_CLIENT_SECRET}"
  tenant_id       = "${data.external.connectionVars.result.ARM_TENANT_ID}"
}

#Call environment module for subscription number 2
module "ct-terraform02-module" {
  source    = "./subscriptionConfigs"
  providers = {
    azurerm = "azurerm.ct-terraform02"
  }
  prefix = "ct-terraform02"
  region = "eastus2"
}
