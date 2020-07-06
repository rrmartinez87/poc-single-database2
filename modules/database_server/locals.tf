/*
  Default values that must be provided according to architecture and can't be setteable from outside the module,
  or values that can be reused along the module.
*/

locals {

    // The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server).
    server_version = "12.0"

    // Flag to indicate whether to deny public access network.
    public_network_access = false

    // The server minimal TLS version needed.
    tls_version = "1.2"

    // Server connection policy setting, this one reduces latency and improves throughput.
    connection_type = "Redirect"

    // Type of content for the server admin secret.
    server_admin_secret_content_type = "SQL Server Admin"

    // Advanced Threat Protection is always enable.
    server_security_alert_policy_state = "Enabled"

    // Threat Protection email administrator accounts is enabled by default.
    threat_protection_email_admin_account = true

    // Enable Vulnerability Assessment recurring scans by default.
    vulnerability_assessment_recurring_scans = true

    // Vulnerability Assessment email administrator accounts is enabled by default.
    vulnerability_assessment_email_account_admins = true
}