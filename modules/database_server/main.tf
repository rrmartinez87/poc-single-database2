//--- Create SQL Server Admin secret if requested
//------------------------------------------------
resource "azurerm_key_vault_secret" "secret" {
    
    // Create secret in Azure Key Vault for the server admin password as indicated
    count = var.create_database_server && var.create_server_admin_secret ? 1 : 0

    // Arguments required by Terraform API
    name = var.server_admin_key_vault_secret_name
    value = var.server_admin_password
    content_type = local.server_admin_secret_content_type
    key_vault_id = var.server_admin_key_vault_id
}


//--- Get SQL Server Admin secret from Azure key Vault
data "azurerm_key_vault_secret" "sqladmin" {

    // Arguments required by Terraform API
    name = var.server_admin_key_vault_secret_name
    key_vault_id = var.server_admin_key_vault_id

    // If a secret is being created as part of the process take it, otherwise get info from an existing key vault
    depends_on = [ azurerm_key_vault_secret.secret ]
}


//--- Create Server Logging/Auditing storage account
resource "azurerm_storage_account" "auditing" {
    
    name = var.auditing_storage_account_name
    resource_group_name = var.resource_group
    location = var.location
    account_tier = var.auditing_storage_account_tier
    account_replication_type = var.auditing_storage_account_replication_type
}


//--- Azure SQL Database Server resource definition
//--------------------------------------------------
resource "azurerm_mssql_server" "database_server" {

    // Arguments required by Terraform API
    name = var.server_name
    resource_group_name = var.resource_group
    location = var.location
    version = local.server_version
    administrator_login = var.server_admin_login
    administrator_login_password = data.azurerm_key_vault_secret.sqladmin.value

    // Optional Terraform resource manager arguments but required by architecture
    connection_policy = local.connection_type
    public_network_access_enabled = local.public_network_access
    tags = var.tags

    // Config Azure AD administrator
    azuread_administrator {
        login_username = var.azuread_admin_login
        object_id = var.azuread_admin_object_id
        tenant_id = var.azuread_admin_tenant_id
    }

    //--- Enable Logging/Auditing
    //--- TODO: integrate with KPMG Logging subscription
    extended_auditing_policy {
        storage_endpoint = azurerm_storage_account.auditing.primary_blob_endpoint
        storage_account_access_key = azurerm_storage_account.auditing.primary_access_key
        storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary
        retention_in_days = var.retention_in_days
    }
}


//--- Set database server TLS version after server creation (unsupported Azure provider argument)
resource "null_resource" "set_tls_version" { 
    
    provisioner local-exec {
        
        // PowerShell command to update SQL Server TLS version
        command = <<-EOT
            Set-AzSqlServer `
                -ServerName ${var.server_name} `
                -ResourceGroupName ${var.resource_group} `
                -MinimalTlsVersion ${local.tls_version}
        EOT

        interpreter = ["pwsh", "-Command"]
    }

    // Setting TLS version requires a previously logical database server to be created
    depends_on = [ azurerm_mssql_server.database_server ]
}


//--- Enable Advance Data Security (ADS) configuration
//-----------------------------------------------------
resource "azurerm_storage_account" "ads_storage" {
    
    name = var.advanced_data_security_storage_account_name
    resource_group_name = var.resource_group
    location = var.location
    account_tier = var.advanced_data_security_storage_account_tier
    account_replication_type = var.advanced_data_security_storage_account_replication_type
}


//--- Storage container definition
resource "azurerm_storage_container" "ads_container" {
    
    name = var.advanced_data_security_storage_container_name
    storage_account_name = azurerm_storage_account.ads_storage.name
}


//--- Advanced Threat Protection settings
resource "azurerm_mssql_server_security_alert_policy" "threat_protection" {
    resource_group_name = var.resource_group
    server_name = azurerm_mssql_server.database_server.name
    state = local.server_security_alert_policy_state
    email_account_admins = local.threat_protection_email_admin_account
    email_addresses = var.threat_protection_email_addresses
}


//--- Vulnerability Assessment settings
resource "azurerm_mssql_server_vulnerability_assessment" "vulnerability_assessment" {
    server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.threat_protection.id
    storage_container_path = "${azurerm_storage_account.ads_storage.primary_blob_endpoint}${azurerm_storage_container.ads_container.name}/"
    storage_account_access_key = azurerm_storage_account.ads_storage.primary_access_key

    recurring_scans {
        enabled = local.vulnerability_assessment_recurring_scans
        email_subscription_admins = local.vulnerability_assessment_email_account_admins
        emails = var.vulnerability_assessment_email_addresses
    }
}