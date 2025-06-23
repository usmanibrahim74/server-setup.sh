echo "Removing MySQL..."
  apt-get purge -y mysql-server mysql-client mysql-common
  rm -rf /etc/mysql /var/lib/mysql
  apt-get autoremove -y --purge
