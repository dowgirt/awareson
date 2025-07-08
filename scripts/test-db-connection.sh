#!/bin/bash

set -e

if sqlcmd -S "$DB_SERVER" -d "$DB_NAME" -U "$DB_USER" -P "$DB_PASSWORD" -Q "SELECT 1" -N -b; then
  echo "DB connection successful"
  exit 0
else
  echo "DB connection failed"
  exit 1
fi