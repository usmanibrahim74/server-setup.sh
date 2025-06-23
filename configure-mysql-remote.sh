#!/bin/bash

echo "Configuring MySQL for remote access..."

# Create MySQL configuration directory and file for remote access
mkdir -p /etc/mysql/mysql.conf.d/
  cat > /etc/mysql/mysql.conf.d/remote.cnf <<EOF
[mysqld]
bind-address = 0.0.0.0

# Connection limits
max_connections = 100
max_user_connections = 20
EOF

# Configure firewall
ufw allow 3306/tcp

# Set proper permissions and restart MySQL
  chmod 644 /etc/mysql/conf.d/remote.cnf

# Ensure MySQL service is started and enabled
systemctl enable mysql
  systemctl restart mysql

# Wait for MySQL to fully start
sleep 5
# Verify configuration
echo "Configuration complete. Verifying settings..."
netstat -tlpn | grep 3306
ufw status | grep 3306

echo "MySQL configured for remote access. Please verify:"
echo "1. MySQL is running and listening (see netstat output above)"
echo "2. UFW is enabled and port 3306 is allowed (see ufw output above)"
echo "3. You can connect using: mysql -h <server_ip> -u appforce_super -p"
