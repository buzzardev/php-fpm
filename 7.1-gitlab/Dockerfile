FROM        php:7.1-fpm
MAINTAINER  Bart Reunes "@MetalArend"

# Install packages
RUN apt-get update \
    && apt-get install -y git curl wget zip unzip zlib1g-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql

# Add timezone
RUN echo "date.timezone=Europe/Brussels" > /usr/local/etc/php/conf.d/timezone.ini

# Install Composer
RUN wget https://composer.github.io/installer.sig -O - -q | tr -d '\n' > installer.sig \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === file_get_contents('installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php'); unlink('installer.sig');" \
    && php -r "rename('composer.phar', '/usr/local/bin/composer');"

# Clean image
RUN apt-get autoremove -yq --purge \
    && apt-get clean \
    && apt-get -f install \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*
