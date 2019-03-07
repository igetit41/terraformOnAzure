
variable "prefix" {}
variable "region" {}

provider "azurerm" {}

//Config for second subscription
resource "azurerm_resource_group" "first-rg" {
  provider = "azurerm"
  name     = "${var.prefix}-rg01"
  location = "${var.region}-rg01"
}