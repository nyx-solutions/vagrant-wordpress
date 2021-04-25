#!/usr/bin/env bash

mkdir -p /etc/php/ssl

mv "/etc/php/${PHP_VERSION}/fpm/php.ini" "/etc/php/${PHP_VERSION}/fpm/php.ini.default"

cp "/vagrant/vagrant-wordpress/php/ssl/cacert.pem"  "/etc/php/ssl/cacert.pem"
cp "/vagrant/vagrant-wordpress/php/php.ini"  "/etc/php/${PHP_VERSION}/fpm/php.ini"
cp "/vagrant/vagrant-wordpress/php/20-xdebug.ini" "/etc/php/${PHP_VERSION}/fpm/conf.d/"
cp "/vagrant/vagrant-wordpress/php/www.conf" "/etc/php/${PHP_VERSION}/fpm/pool.d/"

# point to correct .sock file in the nginx v
sed -i "s/%%php_version%%/${PHP_VERSION}/" "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

update-alternatives --set php "/usr/bin/php${PHP_VERSION}"
