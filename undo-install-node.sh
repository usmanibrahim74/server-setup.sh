echo "Removing Node.js..."
  apt-get purge -y nodejs
  rm -rf /etc/apt/sources.list.d/nodesource.list
  apt-get update -qq
