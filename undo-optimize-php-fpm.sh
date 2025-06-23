echo "Reverting PHP-FPM optimizations..."
  sed -i 's/^pm = .*/pm = dynamic/' /etc/php/8.3/fpm/pool.d/www.conf
  sed -i 's/^pm.max_children = .*/pm.max_children = 5/' /etc/php/8.3/fpm/pool.d/www.conf
  sed -i 's/^pm.process_idle_timeout = .*/;pm.process_idle_timeout = 10s/' /etc/php/8.3/fpm/pool.d/www.conf
  sed -i 's/^env\[PATH\] = .*/;env[PATH] =/' /etc/php/8.3/fpm/pool.d/www.conf
