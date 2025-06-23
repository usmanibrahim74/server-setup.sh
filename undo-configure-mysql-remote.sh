echo "Reverting MySQL remote access..."
  rm -f /etc/mysql/mysql.conf.d/remote.cnf
  systemctl restart mysql
