echo "Which PHP version would you like to install? (e.g. 8.2, 8.3): "
read PHP_VERSION

if [[ ! $PHP_VERSION =~ ^[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid PHP version format. Please use format like 8.2 or 8.3"
    exit 1
fi

echo "Installing PHP $PHP_VERSION and extensions..."

  apt install -y \
    php$PHP_VERSION-fpm \
    php$PHP_VERSION-common \
    php$PHP_VERSION-mysql \
    php$PHP_VERSION-xml \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-gd \
    php$PHP_VERSION-imagick \
    php$PHP_VERSION-cli \
    php$PHP_VERSION-dev \
    php$PHP_VERSION-imap \
    php$PHP_VERSION-mbstring \
    php$PHP_VERSION-opcache \
    php$PHP_VERSION-soap \
    php$PHP_VERSION-zip \
    php$PHP_VERSION-bcmath \
    php$PHP_VERSION-intl
