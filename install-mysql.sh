#!/bin/bash

MYSQL_ROOT_PASS="${MYSQL_ROOT_PASS:-root}"

# Check if MySQL is installed
if command -v mysql >/dev/null 2>&1; then
    echo "MySQL is already installed"
    exit 0
fi

echo "Installing MySQL Server..."

# Install MySQL without prompt
export DEBIAN_FRONTEND=noninteractive

# Pre-configure MySQL root password
  debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASS"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASS"

# Update package list
apt update

# Install MySQL server
if apt install -y mysql-server; then
    echo "MySQL Server installed successfully"

    # Start MySQL service
    systemctl start mysql

    # Enable MySQL to start on boot
    systemctl enable mysql
else
    echo "Error: MySQL Server installation failed"
    exit 1
fi
