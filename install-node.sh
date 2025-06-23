echo "Installing Node.js LTS and npm..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
  apt-get install -y nodejs
# npm is included with nodejs installation, but let's verify both versions
echo "Installed versions:"
node --version
npm --version
