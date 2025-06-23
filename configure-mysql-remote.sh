echo "Configuring MySQL for remote access..."
  cat > /etc/mysql/mysql.conf.d/remote.cnf <<EOF
[mysqld]
bind-address = 0.0.0.0

# Connection limits
max_connections = 100
max_user_connections = 20
EOF

  systemctl restart mysql
