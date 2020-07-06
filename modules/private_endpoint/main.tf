//--- Disable network policies in order to deploy the provate endpoint.
// Network policies like network security groups (NSG) are not supported for private endpoints.
// In order to deploy a Private Endpoint on a given subnet, an explicit disable setting is required on that subnet.
// This setting is only applicable for the Private Endpoint. For other resources in the subnet,
// access is controlled based on Network Security Groups (NSG) security rules definition.
resource "null_resource" "disable_subnet_network_policy" { 
    
    provisioner local-exec {

        command = <<-EOT
            $virtualNetwork = Get-AzVirtualNetwork `
                -ResourceGroupName ${var.vnet_resource_group} `
                -Name ${split("/", var.vnet_id)[length(split("/", var.vnet_id)) - 1]}
   
            ($virtualNetwork | Select -ExpandProperty subnets | Where-Object `
                {$_.Name -eq '${split("/", var.subnet_id)[length(split("/", var.subnet_id)) - 1]}'} ).PrivateEndpointNetworkPolicies = "Disabled"
 
            $virtualNetwork | Set-AzVirtualNetwork
        EOT

        interpreter = ["pwsh", "-Command"]
    }
}


//--- Create a private endpoint to connect to the database server using private access
resource "azurerm_private_endpoint" "endpoint" {
  
    name = var.private_endpoint_name
    resource_group_name = var.resource_group
    location = var.location
    subnet_id = var.subnet_id
    tags = var.tags

    private_service_connection {
        name = var.private_service_connection_name
        private_connection_resource_id = var.database_server_id
        is_manual_connection = local.requires_manual_approval
        subresource_names = local.subresource_names
    }

    // Network policies for the subnet must be disables before creating a private endpoint
    depends_on = [ null_resource.disable_subnet_network_policy ]
}


//--- Create a Private DNS Zone for SQL Database domain.
resource "azurerm_private_dns_zone" "zone" {
  
    name = var.private_dns_zone_name
    resource_group_name = var.resource_group
    tags = var.tags
}

//--- Create an association link with the Virtual Network.
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  
    name = var.private_dns_zone_vnet_link_name
    resource_group_name = var.resource_group
    private_dns_zone_name = azurerm_private_dns_zone.zone.name
    virtual_network_id = var.vnet_id
    tags = var.tags
}


//--- Create a DNS Zone Group to associate the private endpoint with the Private DNS Zone.
resource "null_resource" "set_private_dns_zone_group" { 
    
    provisioner local-exec {

        command = <<-EOT
          $config = New-AzPrivateDnsZoneConfig `
              -Name ${var.private_dns_zone_config_name} `
              -PrivateDnsZoneId ${azurerm_private_dns_zone.zone.id}

          New-AzPrivateDnsZoneGroup `
              -Name ${var.private_dns_zone_group_name} `
              -ResourceGroupName ${var.resource_group} `
              -PrivateEndpointName ${azurerm_private_endpoint.endpoint.name} `
              -PrivateDnsZoneConfig $config
        EOT

        interpreter = ["pwsh", "-Command"]
    }

    depends_on = [ azurerm_private_dns_zone_virtual_network_link.link ]
}