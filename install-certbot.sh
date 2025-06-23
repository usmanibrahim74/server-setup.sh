if command -v certbot >/dev/null 2>&1; then
    echo "Certbot is already installed"
    exit 0
fi

echo "Installing Certbot..."
apt install certbot python3-certbot-nginx
