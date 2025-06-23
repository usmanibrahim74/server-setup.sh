read -p "Domain name for certbot (leave empty to skip): " DOMAIN
if [ -n "$DOMAIN" ]; then
    echo "Creating SSL certificate for $DOMAIN..."
    certbot --nginx -d $DOMAIN --non-interactive --agree-tos --register-unsafely-without-email --redirect
  fi
