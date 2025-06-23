echo "Checking for Node.js installation..."
if command -v node &> /dev/null; then
    echo "Node.js is already installed:"
    node --version
    npm --version
else
echo "Installing Node.js LTS and npm..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
  apt install -y nodejs
echo "Installed versions:"
node --version
npm --version
fi

npm install -g vhost-generator
