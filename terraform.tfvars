//--- Common variables
//---------------------
resource_group = "rg-sql-single-database2"
location = "westus2"
tags = {
    environment = "dev"
    product = "mvp"
    sql_type = "single"
}


//--- Database server variables
//------------------------------
server_name = "yuma-sqlsvr-rafael"
server_admin_login = "yuma-sqlusr"
create_server_admin_secret = false
server_admin_password = "Passw0rd"
server_admin_key_vault_secret_name = "sqlsvr-admin"
server_admin_key_vault_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-support/providers/Microsoft.KeyVault/vaults/yuma-keys"
azuread_admin_login = "rafael.martinez@globant.com"
azuread_admin_object_id = "adc78f07-0628-4143-aa66-3b69bf3ff237"
azuread_admin_tenant_id = null

//--- Server logging/auditing variables
auditing_storage_account_name = "yumaauditingstgacc2"
auditing_storage_account_tier = "Standard"
auditing_storage_account_replication_type = "LRS"
storage_account_access_key_is_secondary = false
retention_in_days = 0

//--- Advanced Data Security (ADS) variables
advanced_data_security_storage_account_name = "yumaadsstgacc2"
advanced_data_security_storage_account_tier = "Standard"
advanced_data_security_storage_account_replication_type = "LRS"
advanced_data_security_storage_container_name = "yumaadsstgcon"
threat_protection_email_addresses = ["rafael.martinez@globant.com"]
vulnerability_assessment_email_addresses = ["rafael.martinez@globant.com"]


//--- Single database variables
//------------------------------
single_database_name = "singledb-mvp"
//database_server_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-single-database/providers/Microsoft.Sql/servers/yuma-sqlsvr"
service_tier = "Basic" //ElasticPool//"GP_S_Gen5_2"
max_size_gb = 2
collation = "SQL_Latin1_General_CP1_CI_AS"
license_type = "BasePrice"
auto_pause_delay_in_minutes = 60 // tf only supports from 60 mins ahead
min_vcores_capacity = 1
secondary_replicas_count = 1
zone_redundant  = false
elastic_pool_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-single-database2/providers/Microsoft.Sql/servers/yuma-sqlsvr-rafael/elasticPools/yuma-elastic"

// Short term backup retention policy settings
short_term_backup_retention_days = 7

// Long term backup retention policy settings
long_term_backup_weekly_retention = "PT0S"
long_term_backup_monthly_retention = "PT0S"
long_term_backup_yearly_retention = "PT0S"
long_term_backup_week_of_year = 1


//--- VNet/Subnet
//----------------
create_vnet = true
vnet_name = "vnet-endpoint"
vnet_address_space = "10.0.0.0/16"
subnet_name = "subnet-endpoint"
subnet_address_prefixes = ["10.0.1.0/24"]


//--- Private Endpoint variables
//-------------------------------
vnet_resource_group = "rg-sql-single-database2"
private_endpoint_name = "private-endpoint"
subnet_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-single-database2/providers/Microsoft.Network/virtualNetworks/vnet-endpoint/subnets/subnet-endpoint"
private_service_connection_name = "any_optinal_name"
vnet_id = "/subscriptions/a7b78be8-6f3c-4faf-a43d-285ac7e92a05/resourceGroups/rg-sql-single-database2/providers/Microsoft.Network/virtualNetworks/vnet-endpoint"

//--- DNS configuration
private_dns_zone_name = "privatelink.database.windows.net"
private_dns_zone_vnet_link_name = "private_dsn_zone_vnet_link"
private_dns_zone_config_name = "private_dns_zone_config_name"
private_dns_zone_group_name = "private_dns_zone_group_name"
