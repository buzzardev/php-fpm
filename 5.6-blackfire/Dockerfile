FROM        php:5.6-fpm
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
        mysqli pdo_mysql #pdo
        #php5-imagick php-pear
        #opcache

RUN apt-get update && \
    apt-get install libldap2-dev -y && \
    rm -rf /var/lib/apt/lists/* && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-install ldap

# Install Blackfire
RUN version=$(php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;") \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/$version \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so $(php -r "echo ini_get('extension_dir');")/blackfire.so \
    && printf "extension=blackfire.so\nblackfire.agent_socket=tcp://blackfire:8707\n" > $PHP_INI_DIR/conf.d/blackfire.ini

# Clean image
RUN apt-get autoremove -yq --purge \
    && apt-get clean \
    && apt-get -f install \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*

# Add configuration
ADD . /container
RUN cp /container/conf/php.ini /usr/local/etc/php
RUN cp /container/conf/php-fpm.conf /usr/local/etc/php-fpm.conf
