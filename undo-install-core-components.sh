echo "Removing core components..."
  apt purge -y nginx git curl software-properties-common \
    apt-transport-https ca-certificates gnupg2 ufw
  apt autoremove -y --purge
