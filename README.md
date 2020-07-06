Parameters:
-----------


# Private Endpoint

When using an existing subnet to deploy a private endpoint make sure that service endpoint setting is marked as Microsoft.Sql in the subnet and private endopoint network policies are disabled. The following powershell script may be used to achieve this purpose:

    $vnet = Get-AzVirtualNetwork -Name "vnet-endpoint" -ResourceGroupName "rg-sql-support"
    Set-AzVirtualNetworkSubnetConfig -Name "subnet-endpoint" -VirtualNetwork $vnet -AddressPrefix "10.1.0.0/24" -PrivateEndpointNetworkPoliciesFlag "Disabled"
