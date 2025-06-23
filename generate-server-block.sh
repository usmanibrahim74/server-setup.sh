#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Get user inputs with defaults
default_domain="staging.appforcepro.com"
default_root="/var/www/appforce/public"
default_php="8.3"

read -p "Enter domain name (default: ${default_domain}): " domain
domain=${domain:-$default_domain}

read -p "Enter root directory (default: ${default_root}): " root_dir
root_dir=${root_dir:-$default_root}

read -p "Enter PHP version (default: ${default_php}): " php_version
php_version=${php_version:-$default_php}

read -p "Use Let's Encrypt certificates? (y/n) [y]: " use_le
use_le=${use_le:-y}

# Set SSL certificate paths
if [[ "${use_le,,}" =~ ^y(es)?$ ]]; then
    ssl_cert="/etc/letsencrypt/live/${domain}/fullchain.pem"
    ssl_key="/etc/letsencrypt/live/${domain}/privkey.pem"
else
    read -p "Enter full path to SSL certificate: " ssl_cert
    read -p "Enter full path to SSL private key: " ssl_key
fi

# Check if configuration already exists
config_file="/etc/nginx/sites-available/${domain}.conf"
enabled_file="/etc/nginx/sites-enabled/${domain}.conf"

if [ -f "$config_file" ] || [ -f "$enabled_file" ]; then
    echo "Configuration for ${domain} already exists!" >&2
    read -p "Do you want to overwrite it? (y/n) [n]: " overwrite
    overwrite=${overwrite:-n}
    if [[ ! "${overwrite,,}" =~ ^y(es)?$ ]]; then
        echo "Aborting..." >&2
        exit 1
    fi
    # Remove existing symlink if it exists
    [ -L "$enabled_file" ] && rm "$enabled_file"
fi
cat > "$config_file" <<EOF
# HTTP redirect to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name ${domain};
    return 301 https://\$host\$request_uri;
}

# HTTPS server block
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name ${domain};
    root ${root_dir};
    index index.php index.html index.htm;

    # SSL Configuration
    ssl_certificate ${ssl_cert};
    ssl_certificate_key ${ssl_key};
    ssl_trusted_certificate ${ssl_cert%/*}/chain.pem;

    # SSL Settings
    ssl_session_timeout 1d;
    ssl_session_cache shared:MozSSL:10m;
    ssl_session_tickets off;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384';
    ssl_prefer_server_ciphers off;
    ssl_ecdh_curve secp384r1;
    ssl_stapling on;
    ssl_stapling_verify on;
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;

    # Security headers
    add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-XSS-Protection "1; mode=block" always;
    add_header Referrer-Policy "strict-origin-when-cross-origin" always;
    add_header Content-Security-Policy "default-src 'self' https:; font-src 'self' https: data:; img-src 'self' https: data:; script-src 'self' https: 'unsafe-inline'; style-src 'self' https: 'unsafe-inline'" always;

    # Laravel front controller pattern
    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    # PHP handling with increased timeouts
    location ~ \.php\$ {
        fastcgi_pass unix:/var/run/php/php${php_version}-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
        include fastcgi_params;

        # Timeout settings
        fastcgi_read_timeout 300;
        fastcgi_connect_timeout 60;
        fastcgi_send_timeout 180;
    }

    # Security - deny access to hidden files
    location ~ /\.(?!well-known).* {
        deny all;
        access_log off;
        log_not_found off;
    }

    # Deny access to sensitive files
    location ~* ^/(\.env|\.env.example|composer\.lock|\.git) {
        deny all;
        return 403;
    }

    # Protect system directories
    location ~* /(storage|bootstrap|config|database|resources|routes|tests|node_modules) {
        deny all;
        return 403;
    }

    # Optimize static file serving
    location ~* \.(jpg|jpeg|gif|png|css|js|ico|webp|svg|woff2)\$ {
        expires 365d;
        add_header Cache-Control "public, immutable";
        try_files \$uri =404;
    }

    # Disable logging for favicon & robots.txt
    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    # Error handling
    error_page 404 /index.php;
    error_page 500 502 503 504 /error.html;

    # Gzip compression
    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_min_length 1024;
    gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;
}
EOF

echo "Configuration created at ${config_file}"

# Enable site
read -p "Enable this site? (y/n) [y]: " enable_site
enable_site=${enable_site:-y}
if [[ "${enable_site,,}" =~ ^y(es)?$ ]]; then
    # Remove existing symlink if it exists
    [ -L "$enabled_file" ] && rm "$enabled_file"
    ln -s "$config_file" "$enabled_file"
    if nginx -t; then
        systemctl reload nginx
        echo "Nginx configuration reloaded successfully"
    else
        echo "Nginx configuration test failed" >&2
        exit 1
    fi
else
    echo "Site configuration created but not enabled"
fi
