echo "Configuring firewall..."
  ufw allow OpenSSH
  ufw allow 'Nginx Full'
  ufw --force enable
