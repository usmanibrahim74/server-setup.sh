read -p "Domain name for certbot (leave empty to skip): " DOMAIN
 if [ -n "$DOMAIN" ]; then
    echo "Removing SSL certificate for $DOMAIN..."
    certbot delete --cert-name $DOMAIN
  fi
