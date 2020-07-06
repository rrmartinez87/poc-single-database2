//--- Azure SQL Single Database resource definition
//-------------------------------------------------
resource "azurerm_mssql_database" "singledb" {

    // Arguments required by Terraform API
    name = var.single_database_name
    server_id = var.database_server_id

    // Optional Terraform resource manager arguments but required by architecture
    sku_name = var.service_tier
    max_size_gb = var.max_size_gb
    collation = var.collation
    license_type = var.license_type
    tags = var.tags

    //--- These parameters apply only to General Purpose Serverless service/compute tier
    auto_pause_delay_in_minutes = (
        substr(var.service_tier, 0, length(local.general_purpose_serverless_service_tier_prefix)) == 
            local.general_purpose_serverless_service_tier_prefix && 
            var.auto_pause_delay_in_minutes >= local.min_auto_pause_supported ?
            var.auto_pause_delay_in_minutes : null
    )
    min_capacity = (
        substr(var.service_tier, 0, length(local.general_purpose_serverless_service_tier_prefix)) == 
            local.general_purpose_serverless_service_tier_prefix ? var.min_vcores_capacity : null
    )
    
    //--- This parameter applies only to Hyperscale service tier
    read_replica_count = (
        substr(var.service_tier, 0, length(local.hyperscale_service_tier_prefix)) == 
            local.hyperscale_service_tier_prefix ? var.secondary_replicas_count : null
    )

    //--- These parameters apply only to Premium and Business Critical service tiers
    read_scale = (
        substr(var.service_tier, 0, length(local.premium_service_tier_prefix)) == local.premium_service_tier_prefix || 
        substr(var.service_tier, 0, length(local.business_critical_service_tier_prefix)) == 
            local.business_critical_service_tier_prefix ? local.read_scale_out : null
    )
    zone_redundant = (
        substr(var.service_tier, 0, length(local.premium_service_tier_prefix)) == local.premium_service_tier_prefix || 
        substr(var.service_tier, 0, length(local.business_critical_service_tier_prefix)) == 
            local.business_critical_service_tier_prefix ? var.zone_redundant : null
    )

    //--- This parameter applies only when creating single pooled database
    elastic_pool_id = var.service_tier == local.elastic_pool_sku_name ? var.elastic_pool_id : null
}


//--- Set SHORT TERM backup retention policy after database creation
resource "null_resource" "set_backup_short_term_retention_policy" { 
    
    provisioner local-exec {
        
        command = <<-EOT
            Set-AzSqlDatabaseBackupShortTermRetentionPolicy `
                -ResourceGroupName ${var.resource_group_name} `
                -ServerName ${split("/", var.database_server_id)[length(split("/", var.database_server_id)) - 1]} `
                -DatabaseName ${azurerm_mssql_database.singledb.name} `
                -RetentionDays ${var.short_term_backup_retention_days}
        EOT

        interpreter = ["pwsh", "-Command"]
    }

    depends_on = [ azurerm_mssql_database.singledb ]
}


//--- Set LONG TERM backup retention policy after database creation
resource "null_resource" "set_backup_long_term_retention_policy" { 
    
    provisioner local-exec {
        
        command = <<-EOT
            Set-AzSqlDatabaseBackupLongTermRetentionPolicy `
                -ResourceGroupName ${var.resource_group_name} `
                -ServerName ${split("/", var.database_server_id)[length(split("/", var.database_server_id)) - 1]} `
                -DatabaseName ${azurerm_mssql_database.singledb.name} `
                -WeeklyRetention ${var.long_term_backup_weekly_retention} `
                -MonthlyRetention ${var.long_term_backup_monthly_retention} `
                -YearlyRetention ${var.long_term_backup_yearly_retention} `
                -WeekOfYear ${var.long_term_backup_week_of_year}
        EOT

        interpreter = ["pwsh", "-Command"]
    }

    depends_on = [ azurerm_mssql_database.singledb ]
}