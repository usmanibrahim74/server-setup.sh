echo "Removing PHP repository..."
  add-apt-repository -y --remove ppa:ondrej/php
  apt-key del 4F4EA0AAE5267A6C
  apt update
