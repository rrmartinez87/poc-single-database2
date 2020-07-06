/*
  Input variable definitions to create an Azure SQL Single Database resource and its dependences
*/

//--- Common variables
//--------------------
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
//-----------------------------
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

variable "server_admin_password"  { 
    description = "The administrator password for the new server, required when create_server_admin_secret is true"
    type = string
    default = null
}

variable "create_server_admin_secret"  { 
    description = "The administrator login name for the new server. Changing this forces a new resource to be created."
    type = bool
    default = false
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
}

variable "retention_in_days" { 
    description = "Specifies the number of days to retain logs for in the storage account. A value of 0 means unlimited."
    type = number
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


//--- Single database variables
//-----------------------------
variable "single_database_name" { 
    description = "The name of the Ms SQL Database. Changing this forces a new resource to be created."
    type = string
}

variable "service_tier" { 
    description = <<DESC
            Specifies the name of the sku used by the database. Changing this forces a new resource to be created.
            For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100.
            Please refer to module README.md for additional information on how to use this parameter.
        DESC
    type = string
}

variable "max_size_gb" { 
    description = "The max size of the database in gigabytes."
    type = number
    default = null
}

variable "collation" { 
    description = "Specifies the collation of the database. Changing this forces a new resource to be created."
    type = string
    default = "SQL_Latin1_General_CP1_CI_AS"
}

variable "license_type" { 
    description = <<DESC
            Specifies the license type applied to this database. Possible values are LicenseIncluded
            (Azure Hybrid Benefit included) and BasePrice (Azure Hybrid Benefit not included).
        DESC
    type = string
    default = "BasePrice"
}

variable "auto_pause_delay_in_minutes" { 
    description = <<DESC
            Time in minutes after which database is automatically paused. A value of -1 means that automatic
            pause is disabled. This property is only settable for General Purpose Serverless databases.
        DESC
    type = number
    default = -1
}

variable "min_vcores_capacity" { 
    description = <<DESC
        Minimal vCores capacity that database will always have allocated, if not paused.
        This property is only settable for General Purpose Serverless databases.
        DESC
    type = number
    default = null
}

variable "secondary_replicas_count" { 
    description = <<DESC
        The number of readonly secondary replicas associated with the database to which readonly
        application intent connections may be routed. This property is only settable for
        Hyperscale edition databases.
        DESC
    type = number
    default = 0
}

variable "zone_redundant" { 
    description = <<DESC
            Whether or not this database is zone redundant, which means the replicas of this database
            will be spread across multiple availability zones. This property is only settable for
            Premium and Business Critical databases.
        DESC
    type = bool
    default = false
}

variable "elastic_pool_id" { 
    description = <<DESC
            Specifies the ID of the elastic pool containing this database.
            Changing this forces a new resource to be created.
        DESC
    type = string
    default = null
}


//--- Short term backup retention policy variables
variable "short_term_backup_retention_days" { 
    description = "The backup retention setting, in days. It must be an integer between 1 and 7."
    type = number
}


//--- Long term backup retention policy variables
variable "long_term_backup_weekly_retention" { 
    description = "The Weekly Retention. If just a number is passed instead of an ISO 8601 string, days will be assumed as the units. There is a minimum of 7 days and a maximum of 10 years."
    type = string
    default = "PT0S"
}

variable "long_term_backup_monthly_retention" { 
    description = "The Monthly Retention. If just a number is passed instead of an ISO 8601 string, days will be assumed as the units. There is a minimum of 7 days and a maximum of 10 years."
    type = string
    default = "PT0S"
}

variable "long_term_backup_yearly_retention" { 
    description = "The Yearly Retention. If just a number is passed instead of an ISO 8601 string, days will be assumed as the units. There is a minimum of 7 days and a maximum of 10 years."
    type = string
    default = "PT0S"
}

variable "long_term_backup_week_of_year" { 
    description = "The Week of Year, 1 to 52, to save for the Yearly Retention."
    type = number
    default = 1
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