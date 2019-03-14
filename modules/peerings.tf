
locals {
    vnet_ids = [
        "/subscriptions/965c8882-db32-486f-83af-1265fc20af06/resourceGroups/josterhaus01-pd-rg01/providers/Microsoft.Network/virtualNetworks/josterhaus01-pd-vnet01",
        "/subscriptions/d57a9e99-d8ee-4e55-8091-a609a56c9ae0/resourceGroups/josterhaus02-np-rg01/providers/Microsoft.Network/virtualNetworks/josterhaus02-np-vnet01"
    ]
}

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
