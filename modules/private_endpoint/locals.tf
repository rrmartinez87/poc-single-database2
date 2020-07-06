/*
  Default values that must be provided according to architecture and can't be setteable from outside the module
*/

locals {

    // Does the Private Endpoint require Manual Approval from the remote resource owner?
    requires_manual_approval = false

    // A list of subresource names which the Private Endpoint is able to connect to.
    subresource_names = ["sqlServer"]
}