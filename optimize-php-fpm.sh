read -p "Enter PHP version (e.g. 8.3): " PHP_VERSION
echo "Optimizing PHP-FPM for PHP ${PHP_VERSION}..."
sed -i "s/^pm = .*/pm = ondemand/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "s/^pm.max_children = .*/pm.max_children = 50/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "s/^;pm.process_idle_timeout = .*/pm.process_idle_timeout = 10s/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "s/^;env\[PATH\] = .*/env[PATH] = \/usr\/local\/bin:\/usr\/bin:\/bin/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
