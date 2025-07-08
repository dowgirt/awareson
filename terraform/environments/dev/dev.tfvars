# General
project     = "awareson"
environment = "dev"

# Subnet CIDRs
address_space     = ["10.0.0.0/16"]
app_subnet_prefix = "10.0.1.0/28"
db_subnet_prefix  = "10.0.2.0/28"

# Databases configuration
databases = {
  db1 = {
    max_size_gb          = 10
    sku_name             = "S0"
    zone_redundant       = false
    storage_account_type = "Local"
  }
}

# ACR
acr_sku = "Basic"

# App Services SKU
app_service_sku_name = "B1"

# Tags
tags = {
  createdBy = "terraform"
  project   = "awareson"
  owner     = "DevOps Team"
  env       = "dev"
}