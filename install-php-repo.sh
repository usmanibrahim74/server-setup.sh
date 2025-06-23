echo "Adding PHP repository..."
  LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4F4EA0AAE5267A6C
  apt update
