
variable "prefix" {}
variable "region" {}
variable "designation" {}
variable "address_space" {
  type = "list"
}
variable "subnets_names" {
  type = "list"
}
variable "subnets_address_prefixes" {
  type = "list"
}

provider "azurerm" {}

//Config for second subscription
resource "azurerm_resource_group" "first-rg" {
  provider = "azurerm"
  name     = "${var.prefix}-rg01"
  location = "${var.region}"
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "${azurerm_resource_group.test.name}-${var.designation}-vnet01"
  resource_group_name = "${azurerm_resource_group.test.name}"
  address_space       = "${list(var.address_space)}"
  location            = "${var.region}"

  subnet {
    count = "${length(list(var.subnets_address_prefixes))}"
    name           = "${element(var.subnets_names,count.index)}"
    address_prefix = "${element(var.subnets_address_prefixes,count.index)}"
  }
}

