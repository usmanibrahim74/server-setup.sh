#!/bin/bash

# Default values
DEFAULT_REMOTE_USER="remote_admin"
DEFAULT_ALLOWED_CIDR="%" # % means allow from anywhere
DEFAULT_REMOTE_PASS=$(openssl rand -base64 12)

# Prompt for inputs with defaults
read -p "Enter MySQL root password: " MYSQL_ROOT_PASS
#if [ -z "$MYSQL_ROOT_PASS" ]; then
#    echo "Error: MySQL root password cannot be empty"
#    exit 1
#fi

read -p "Enter remote MySQL username [$DEFAULT_REMOTE_USER]: " REMOTE_USER
REMOTE_USER=${REMOTE_USER:-$DEFAULT_REMOTE_USER}

read -p "Enter strong password for $REMOTE_USER [$DEFAULT_REMOTE_PASS]: " REMOTE_PASS
REMOTE_PASS=${REMOTE_PASS:-$DEFAULT_REMOTE_PASS}

read -p "Allow remote access from IP/CIDR (% for anywhere) [$DEFAULT_ALLOWED_CIDR]: " ALLOWED_CIDR
ALLOWED_CIDR=${ALLOWED_CIDR:-$DEFAULT_ALLOWED_CIDR}

echo "Creating MySQL remote user..."
echo "Username: $REMOTE_USER"
echo "Access from: $ALLOWED_CIDR"
echo "Password: $REMOTE_PASS"

  mysql --user=root --password="$MYSQL_ROOT_PASS" <<-EOF
    CREATE USER IF NOT EXISTS '$REMOTE_USER'@'$ALLOWED_CIDR' IDENTIFIED BY '$REMOTE_PASS';

    GRANT ALL PRIVILEGES ON *.* TO '$REMOTE_USER'@'$ALLOWED_CIDR' WITH GRANT OPTION;

    FLUSH PRIVILEGES;
EOF

if [ $? -eq 0 ]; then
    echo "Remote user created successfully!"
else
    echo "Error creating remote user. Please check MySQL root credentials and try again."
    exit 1
fi
