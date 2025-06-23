echo "Optimizing PHP-FPM..."
  sed -i 's/^pm = .*/pm = ondemand/' /etc/php/8.3/fpm/pool.d/www.conf
  sed -i 's/^pm.max_children = .*/pm.max_children = 50/' /etc/php/8.3/fpm/pool.d/www.conf
  sed -i 's/^;pm.process_idle_timeout = .*/pm.process_idle_timeout = 10s/' /etc/php/8.3/fpm/pool.d/www.conf
  sed -i 's/^;env\[PATH\] = .*/env[PATH] = \/usr\/local\/bin:\/usr\/bin:\/bin/' /etc/php/8.3/fpm/pool.d/www.conf
