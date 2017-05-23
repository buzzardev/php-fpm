#!/usr/bin/env bash

docker build --quiet --tag symfony .
docker run --rm -it --name symfony_requirements --env TZ="Europe/Brussels" --volume $PWD:/app -w /app symfony bash -c "
    date
    php -r 'echo date_default_timezone_get();'
    echo ' '
    mkdir -p /usr/local/bin
    curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
    chmod a+x /usr/local/bin/symfony
    if test ! -d test; then
        symfony new test
    fi
    cd test
    curl -LsS https://composer.github.io/installer.sig | tr -d '\n' > installer.sig
    php -r \"copy('https://getcomposer.org/installer', 'composer-setup.php');\"
    php -r \"if (hash_file('SHA384', 'composer-setup.php') === file_get_contents('installer.sig')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;\"
    php composer-setup.php
    php -r \"unlink('composer-setup.php'); unlink('installer.sig');\"
    php -r \"rename('composer.phar', '/usr/local/bin/composer');\"
    composer install --no-progress
    php bin/symfony_requirements
    cd ..
    rm -rf test
"

