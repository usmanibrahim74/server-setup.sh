echo "Removing core components..."
  apt-get purge -y nginx git curl software-properties-common \
    apt-transport-https ca-certificates gnupg2 ufw
  apt-get autoremove -y --purge
