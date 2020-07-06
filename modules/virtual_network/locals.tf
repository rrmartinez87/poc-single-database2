/*
  Default values that must be provided according to architecture and can't be setteable from outside the module
*/

locals {
  service_endpoints = ["Microsoft.Sql"]
  enforce_private_link_endpoint_policies = true
}