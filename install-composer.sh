echo "Checking for Composer..."

# Check if composer is already installed
if command -v composer &> /dev/null; then
    # Check if it's the latest version
    LATEST_VERSION=$(curl -s https://getcomposer.org/versions | grep -o '"latest":"[^"]*"' | cut -d'"' -f4)
    CURRENT_VERSION=$(composer --version | cut -d' ' -f3)

    if [ "$LATEST_VERSION" = "$CURRENT_VERSION" ]; then
        echo "Latest version of Composer ($LATEST_VERSION) is already installed."
        exit 0
    else
        echo "Updating Composer to latest version..."
        composer self-update
        exit 0
    fi
fi

echo "Installing Composer..."
  EXPECTED_CHECKSUM="$(wget -q -O - https://composer.github.io/installer.sig)"
  php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
  ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

  if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]; then
    >&2 echo 'ERROR: Invalid composer installer checksum'
    rm composer-setup.php
    exit 1
  fi

  php composer-setup.php --install-dir=/usr/local/bin --filename=composer
  rm composer-setup.php

echo "Composer installation completed!"
