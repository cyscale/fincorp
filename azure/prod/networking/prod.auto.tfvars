subnets = {
  dmz = {
    name              = "subnet-fincorp-prod-dmz"
    address_prefixes  = ["10.0.1.0/24"]
    service_endpoints = []
    delegation        = []
  }
  postgres = {
    name              = "subnet-fincorp-prod-postgres"
    address_prefixes  = ["10.0.2.0/24"]
    service_endpoints = ["Microsoft.Storage"]
    delegation = [
      {
        name = "fs"
        service_delegation = {
          name = "Microsoft.DBforPostgreSQL/flexibleServers"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
          ]
        }
      }
    ]
  }
}

security_groups = {
  dmz = {
    name = "nsg-fincorp-prod-dmz"
    security_rules = [
      {
        name                       = "http"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_ranges         = [22, 80, 443]
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
  postgres = {
    name = "nsg-fincorp-prod-postgres"
    security_rules = [
      {
        name                       = "postgres"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_ranges         = [5432, 6432]
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }
}

rg_contributor = "68cbbd88-c02c-4232-92a2-0151376e2c72"
