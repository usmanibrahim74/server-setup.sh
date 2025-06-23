read -p "Enter MySQL root password: " MYSQL_ROOT_PASS
read -p "Enter remote MySQL username: " REMOTE_USER
read -p "Allow remote access from IP/CIDR (e.g., 192.168.1.0/24): " ALLOWED_CIDR

echo "Removing MySQL remote user..."
  mysql --user=root --password="$MYSQL_ROOT_PASS" <<-EOF
    DROP USER IF EXISTS '$REMOTE_USER'@'$ALLOWED_CIDR';
    FLUSH PRIVILEGES;
EOF
