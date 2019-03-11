
variable "prefix" {}
variable "region" {}
variable "designation" {}

provider "azurerm" {}

//Config for second subscription
resource "azurerm_resource_group" "first-rg" {
  provider = "azurerm"
  name     = "${var.prefix}-rg01"
  location = "${var.region}"
}
