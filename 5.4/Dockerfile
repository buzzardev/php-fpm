FROM        php:5.4-fpm
MAINTAINER  Bart Reunes "@MetalArend"

# Install packages
RUN apt-get update \
    && apt-get install -y \
        libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \
        libmcrypt-dev \
        zlib1g-dev \
        libicu-dev g++ \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install \
        gd \
        mcrypt \
        zip \
        mbstring \
        intl \
        mysql mysqli pdo_mysql #pdo pdo_mysql

# Clean image
RUN apt-get autoremove -yq --purge \
    && apt-get clean \
    && apt-get -f install \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*

# Add configuration
ADD . /container
RUN cp /container/conf/php.ini /usr/local/etc/php
RUN cp /container/conf/php-fpm.conf /usr/local/etc/php-fpm.conf
