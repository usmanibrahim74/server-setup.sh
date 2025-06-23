echo "Installing required packages..."
  apt install -y \
    nginx \
    git \
    curl \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    ufw
