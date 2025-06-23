read -p "System username for app deployment: " DEPLOY_USER
echo "Creating deployment user: $DEPLOY_USER"
  adduser --disabled-password --gecos "" $DEPLOY_USER
  usermod -aG www-data $DEPLOY_USER
