read -p "System username for app deployment: " DEPLOY_USER
echo "Creating application directory..."
  APP_DIR="/var/www/production"
  mkdir -p $APP_DIR
  chown -R $DEPLOY_USER:www-data $APP_DIR
  chmod 775 $APP_DIR
