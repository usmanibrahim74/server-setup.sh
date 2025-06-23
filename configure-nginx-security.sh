echo "Configuring Nginx security headers..."
  cat > /etc/nginx/conf.d/security.conf <<EOF
# Security headers
add_header X-Frame-Options "SAMEORIGIN";
add_header X-XSS-Protection "1; mode=block";
add_header X-Content-Type-Options "nosniff";
add_header Referrer-Policy "strict-origin";
add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;

# File access restrictions
location ~* \.(env|log|htaccess|htpasswd|gitignore|gitattributes)$ {
    deny all;
}
location ~* ^/(\.git|\.env|storage|config|backups) {
    deny all;
}
