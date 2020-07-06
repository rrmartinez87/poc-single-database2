/*
  Output variable definitions for the Azure virtual network/subnet resource
*/

output "vnet_id" {
  description = "The virtual network ID."
  value = var.create_vnet ? azurerm_virtual_network.vnet[0].id : null
  sensitive = false
}

output "subnet_id" {
  description = "The subnet ID."
  value = var.create_vnet ? azurerm_subnet.subnet[0].id : null
  sensitive = false
}