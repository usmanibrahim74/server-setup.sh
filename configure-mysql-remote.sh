#!/bin/bash

echo "Configuring MySQL for remote access..."

# Create MySQL configuration directory and file for remote access
mkdir -p /etc/mysql/conf.d/
  cat > /etc/mysql/conf.d/remote.cnf <<EOF
[mysqld]
bind-address = 0.0.0.0

# Connection limits
max_connections = 100
max_user_connections = 20
EOF

# Allow MySQL port through firewall
ufw allow 3306/tcp

# Restart MySQL service
  chmod 644 /etc/mysql/conf.d/remote.cnf && systemctl restart mysql

echo "MySQL configured for remote access. Make sure you have:"
echo "1. Created a remote user with proper privileges"
echo "2. Configured your server's security groups/firewall rules"
