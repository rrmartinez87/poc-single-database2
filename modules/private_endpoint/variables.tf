/*
  Input variable definitions for an Azure SQL single database resource and its dependences
*/

//--- Common variables definition
//--------------------------------
variable "resource_group" { 
    description = "The name of the resource group in which to create the elastic pool. This must be the same as the resource group of the underlying SQL server."
    type = string
}

variable "location" { 
    description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
    type = string
}

variable "tags" { 
    description = "A mapping of tags to assign to the resource."
    type = map
}

//--- Private endopoint variables
//--------------------------------
variable "vnet_resource_group" { 
    description = "The name of the resource group in which exists the vnet/subnet where to set network policies disabled."
    type = string
}

variable "subnet_id" {
    description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created."
    type = string
}

variable "private_endpoint_name" {
    description = "Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created."
    type = string
}

variable "private_service_connection_name" {
    description = "Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created."
    type = string
    default = "sql_server_private_service_connection_name"
}

variable "database_server_id" { 
    description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to. Changing this forces a new resource to be created."
    type = string
}

//--- Private DNS zone variables
//-------------------------------
variable "private_dns_zone_name" {
    description = "The name of the Private DNS Zone. Must be a valid domain name."
    type = string
    default = "privatelink.database.windows.net"
}

variable "private_dns_zone_vnet_link_name" {
    description = "The name of the Private DNS Zone Virtual Network Link. Changing this forces a new resource to be created."
    type = string
    default = "private_dns_zone_vnet_link"
}

variable "vnet_id" {
    description = "The Resource ID of the Virtual Network that should be linked to the DNS Zone. Changing this forces a new resource to be created."
    type = string
}

variable "private_dns_zone_config_name" {
    description = "Name of the resource that is unique within a resource group. This name can be used to access the resource."
    type = string
    default = "private_dns_zone_config_name"
}

variable "private_dns_zone_group_name" {
    description = "The name of the private dns zone group."
    type = string
    default = "private_dns_zone_group_name"
}
