
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

output "vnet_peerings" {
  //value = "${azurerm_virtual_network.vnet01.vnet_peerings}"
  value = "${azurerm_virtual_network.vnet01.vnet_peerings != null ? azurerm_virtual_network.vnet01.vnet_peerings : list()}"
}


/*
resource "azurerm_virtual_network_peering" "near_side" {
  count                     = "${length(module.*.azurerm_virtual_network.*)}"
  name                      = "${azurerm_virtual_network.vnet01.name}-${element(module.*.azurerm_virtual_network.*.name,count.index)}"
  resource_group_name       = "${azurerm_resource_group.first-rg.name}"
  virtual_network_name      = "${azurerm_virtual_network.vnet01.name}"
  remote_virtual_network_id = "${element(module.*.azurerm_virtual_network.*.id,count.index)}"
}

resource "azurerm_virtual_network_peering" "far_side" {
  count                     = "${length(module.*.azurerm_virtual_network.*)}"
  name                      = "${element(module.*.azurerm_virtual_network.*.name,count.index)}-${azurerm_virtual_network.vnet01.name}"
  resource_group_name       = "${element(module.*.azurerm_virtual_network.*.resource_group_name,count.index)}"
  virtual_network_name      = "${element(module.*.azurerm_virtual_network.*.name,count.index)}"
  remote_virtual_network_id = "${azurerm_virtual_network.vnet01.name}"
}
*/