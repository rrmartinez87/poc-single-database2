/*
  Default values that must be provided according to architecture and can't be setteable from outside the module,
  or values that can be reused along the module.
*/

locals {

    // If enabled, connections that have application intent set to readonly in their connection string may be routed 
    // to a readonly secondary replica. This property is only settable for Premium and Business Critical databases.
    read_scale_out = false

    // Name of the elastic pol sku name used by Terraform
    elastic_pool_sku_name = "ElasticPool"

    // Service tier prefixes
    premium_service_tier_prefix = "P"
    business_critical_service_tier_prefix = "BC"
    hyperscale_service_tier_prefix = "HS"
    general_purpose_serverless_service_tier_prefix = "GP_S"

    // Minimum time in minutes supported by Terraform configuration (only General Purpose Serverless)
    min_auto_pause_supported = 60
}