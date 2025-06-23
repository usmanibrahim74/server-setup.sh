#!/bin/bash
read -p "Enter MySQL root password: " MYSQL_ROOT_PASS

echo "Securing MySQL..."
  mysql --user=root --password="$MYSQL_ROOT_PASS" <<-EOF
    DELETE FROM mysql.user WHERE User='';
    DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    DROP DATABASE IF EXISTS test;
    DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
    FLUSH PRIVILEGES;
EOF
