echo "Removing MySQL..."
  apt purge -y mysql-server mysql-client mysql-common
  rm -rf /etc/mysql /var/lib/mysql
  apt autoremove -y --purge
