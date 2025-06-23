read -p "System username for app deployment: " DEPLOY_USER
echo "Removing deployment user: $DEPLOY_USER"
  deluser --remove-home $DEPLOY_USER
