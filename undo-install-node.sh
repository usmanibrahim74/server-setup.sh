echo "Removing Node.js..."
  apt purge -y nodejs
  rm -rf /etc/apt/sources.list.d/nodesource.list
  apt update
