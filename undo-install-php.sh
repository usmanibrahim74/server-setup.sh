#!/bin/bash

echo "Which PHP version do you want to remove?"
echo "Available versions:"
php -v | grep -v "PHP"

read -p "Enter PHP version (e.g., 8.3): " PHP_VERSION

if [ -z "$PHP_VERSION" ]; then
    echo "Error: PHP version is required"
    exit 1
fi

echo "Removing PHP $PHP_VERSION..."
apt purge -y php$PHP_VERSION-*
  apt autoremove -y --purge

echo "PHP $PHP_VERSION has been removed."
