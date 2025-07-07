# General

location    = "Poland Central"
project     = "awareson"
environment = "dev"

# Subnet CIDRs

address_space     = ["10.0.0.0/16"]
app_subnet_prefix = "10.0.1.0/28"
db_subnet_prefix  = "10.0.2.0/28"

# DBs 
databases = {
  db1 = {
    max_size_gb    = "1",
    sku_name       = "S0",
    zone_redundant = false
  }
}


# Tags

tags = {
  "createdBy" = "terraform"
  "project"   = "Application"
  "Owner"     = "DevOps Team"
}