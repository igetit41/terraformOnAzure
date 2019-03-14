
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
  name     = "${var.prefix}-${var.designation}-rg01"
  location = "${var.region}"
}

resource "azurerm_virtual_network" "vnet01" {
  name                = "${var.prefix}-${var.designation}-vnet01"
  resource_group_name = "${azurerm_resource_group.first-rg.name}"
  address_space       = "${var.address_space}"
  location            = "${var.region}"
  provisioner "local-exec" {
    command = "echo ,${azurerm_virtual_network.vnet01.id} >> peeringVnets.txt"
  }
}

resource "azurerm_subnet" "vnet01_subnets" {
  count                 = "${length(var.subnets_address_prefixes)}"
  name                  = "${element(var.subnets_names,count.index)}"
  resource_group_name   = "${azurerm_resource_group.first-rg.name}"
  virtual_network_name  = "${azurerm_virtual_network.vnet01.name}"
  address_prefix        = "${element(var.subnets_address_prefixes,count.index)}"
}

output "vnet_name" {
  value = "${azurerm_virtual_network.vnet01.name}"
}
output "vnet_rg" {
  value = "${azurerm_virtual_network.vnet01.resource_group_name}"
}
output "vnet_id" {
  value = "${azurerm_virtual_network.vnet01.id}"
}
