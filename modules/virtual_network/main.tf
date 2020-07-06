//--- Create VNet/Subnet to deploy private endpoint
resource "azurerm_virtual_network" "vnet" {
  
  // Create VNet if requested
  count = var.create_vnet ? 1 : 0

  name = var.vnet_name
  address_space = [var.vnet_address_space]
  location = var.location
  resource_group_name = var.resource_group
  tags = var.tags
}

//--- Create associated subnet
resource "azurerm_subnet" "subnet" {
  
  // Create subnet if requested
  count = var.create_vnet ? 1 : 0

  name = var.subnet_name
  resource_group_name = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes = var.subnet_address_prefixes
  enforce_private_link_endpoint_network_policies = local.enforce_private_link_endpoint_policies
  service_endpoints = local.service_endpoints
}