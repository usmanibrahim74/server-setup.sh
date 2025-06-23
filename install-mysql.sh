echo "Installing MySQL..."
  debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASS"
  debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASS"
  apt-get install -y mysql-server
