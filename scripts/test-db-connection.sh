#!/bin/bash
set -euo pipefail

echo "Installing Microsoft SQL tools..."

# Import Microsoft repo keys and add repo for Ubuntu 22.04 (adjust if your distro differs)
curl -sSL https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl -sSL https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools unixodbc-dev

# Add sqlcmd to PATH
export PATH="$PATH:/opt/mssql-tools/bin"

echo "Testing DB connection..."

# Run sqlcmd with login timeout (-l) 10 seconds, no encryption (-N) to speed up if safe
if sqlcmd -S "$DB_SERVER" -d "$DB_NAME" -U "$DB_USER" -P "$DB_PASSWORD" -Q "SELECT 1" -N -b -l 10; then
  echo "DB connection successful"
  exit 0
else
  echo "DB connection failed"
  exit 1
fi