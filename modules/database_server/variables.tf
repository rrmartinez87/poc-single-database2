/*
  Input variable definitions for an Azure SQL database server resource and its dependences
*/


//--- Common variables
//---------------------
variable "resource_group" { 
    description = "The name of the resource group in which to create the database server. This must be the same as the resource group of the underlying SQL server."
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


//--- Database server variables
//------------------------------
variable "create_database_server" { 
    description = "Flag that indicates whether the database server should be created or not."
    type = bool
    default = true
}

variable "server_name" { 
    description = "The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
    type = string
}

variable "server_admin_login"  { 
    description = "The administrator login name for the new server. Changing this forces a new resource to be created."
    type = string
}

variable "create_server_admin_secret"  { 
    description = "The administrator login name for the new server. Changing this forces a new resource to be created."
    type = bool
    default = false
}

variable "server_admin_password"  { 
    description = "The administrator password for the new server, required when create_server_admin_secret is true"
    type = string
    default = null
}

variable "server_admin_key_vault_secret_name" { 
    description = "Name of the secret in Azure Key Vault where admin password is kept."
    type = string
}

variable "server_admin_key_vault_id" { 
    description = "Azure Key Vault ID where the secret is stored."
    type = string
}

variable "azuread_admin_login"  { 
    description = "The login username of the Azure AD Administrator of this SQL Server."
    type = string
}

variable "azuread_admin_object_id"  { 
    description = "The object id of the Azure AD Administrator of this SQL Server."
    type = string
}

variable "azuread_admin_tenant_id"  { 
    description = "The tenant id of the Azure AD Administrator of this SQL Server."
    type = string
    default = null
}


//--- Logging/auditing storage account variables
//-----------------------------------------------
variable "auditing_storage_account_name" { 
    description = "Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
    type = string
}

variable "auditing_storage_account_tier" { 
    description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
    type = string
}

variable "auditing_storage_account_replication_type" { 
    description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
    type = string
}

variable "storage_account_access_key_is_secondary" { 
    description = "Specifies whether storage_account_access_key value is the storage's secondary key."
    type = bool
    default = false
}

variable "retention_in_days" { 
    description = "Specifies the number of days to retain logs for in the storage account. A value of 0 means unlimited."
    type = number
    default = 0
}


//--- Advance Data Security (ADS) variables
//-----------------------------------------------
variable "advanced_data_security_storage_account_name" { 
    description = " Specifies the name of the storage account. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
    type = string
}

variable "advanced_data_security_storage_account_tier" { 
    description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
    type = string
}

variable "advanced_data_security_storage_account_replication_type" { 
    description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
    type = string
}

variable "advanced_data_security_storage_container_name" { 
    description = "The name of the Container which should be created within the Storage Account."
    type = string
}

variable "threat_protection_email_addresses" { 
    description = "Specifies an array of e-mail addresses to which the alert is sent."
    type = list(string)
}

variable "vulnerability_assessment_email_addresses" { 
    description = "Specifies an array of e-mail addresses to which the scan notification is sent."
    type = list(string)
}