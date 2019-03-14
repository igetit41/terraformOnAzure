#Passed in credentials
data "external" "connectionVars" {
  program = ["sh", "connectionVars.sh" ]
}

#naming Prefix
variable "namePrefix" {
  default = ""
}


data "peering_vnet_list" {
  type = "list"
  default = []
}

#Subscription01 ID
variable "subscription_id01" {}

#Provider for Subscription01
provider "azurerm" {
  alias  = "ct-terraform01"
  subscription_id = "${var.subscription_id01}"
  client_id       = "${data.external.connectionVars.result.ARM_CLIENT_ID}"
  client_secret   = "${data.external.connectionVars.result.ARM_CLIENT_SECRET}"
  tenant_id       = "${data.external.connectionVars.result.ARM_TENANT_ID}"
}

#Subscription01_ZoneA
module "ct-terraform01-module" {
  source    = "./modules"
  providers = {
    azurerm = "azurerm.ct-terraform01"
  }
  prefix = "${var.namePrefix}01"
  region = "westus2"
  designation = "pd"
  address_space = "${list("192.168.0.0/24","192.168.1.0/24")}"
  subnets_names = "${list("GatewaySubnet","Subnet_01")}"
  subnets_address_prefixes = "${list("192.168.0.0/25","192.168.0.128/25")}"
  var.peering_vnet_list = "${merge(var.namePrefix,module.ct-terraform01-module.azurerm_virtual_network)}"
}










#Subscription02 ID
variable "subscription_id02" {}

#Provider for Subscription02
provider "azurerm" {
  alias  = "ct-terraform02"
  subscription_id = "${var.subscription_id02}"
  client_id       = "${data.external.connectionVars.result.ARM_CLIENT_ID}"
  client_secret   = "${data.external.connectionVars.result.ARM_CLIENT_SECRET}"
  tenant_id       = "${data.external.connectionVars.result.ARM_TENANT_ID}"
}

#Subscription02_ZoneA
module "ct-terraform02-module" {
  source    = "./modules"
  providers = {
    azurerm = "azurerm.ct-terraform02"
  }
  prefix = "${var.namePrefix}02"
  region = "eastus2"
  designation = "np"
  address_space = "${list("192.168.128.0/24", "192.168.129.0/24")}"
  subnets_names = "${list("GatewaySubnet","Subnet_01")}"
  subnets_address_prefixes = "${list("192.168.128.0/25","192.168.128.128/25")}"
  var.peering_vnet_list = "${merge(var.namePrefix,module.ct-terraform02-module.azurerm_virtual_network)}"
}



output "output" {
  value = "${var.peering_vnet_list}"
}