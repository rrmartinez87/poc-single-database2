/*
  Input variable definitions for an Azure SQL single database resource and its dependences
*/

//--- Common variables definition
//--------------------------------
variable "resource_group" { 
    description = "The name of the resource group in which to create the vnet."
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


//--- Virtual Network/Subnet variables
//-------------------------------------
variable "create_vnet" { 
    description = "Flag to indicate whether vnet/subnet should be created or not."
    type = bool
}

variable "vnet_name" {
    description = "The name of the virtual network. Changing this forces a new resource to be created."
    type = string
}

variable "vnet_address_space" {
    description = "The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
    type = string
}

variable "subnet_name" {
    description = "The name of the subnet. Changing this forces a new resource to be created."
    type = string
}

variable "subnet_address_prefixes" {
    description = "The address prefixes to use for the subnet."
    type = list(string)
}