#!/usr/bin/env bash

# Start after boot
sudo update-rc.d nginx enable

# copy nginx config
cp /vagrant/vagrant-wordpress/nginx/nginx.conf /etc/nginx/
cp /vagrant/vagrant-wordpress/nginx/snippets/*.nginx /etc/nginx/

# remove default site
if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi

if [ -f /etc/nginx/sites-enabled/default.conf ]; then
  rm /etc/nginx/sites-enabled/default.conf
fi

# copy our site config and symlink it
cp /vagrant/vagrant-wordpress/nginx/site/wordpress.nginx /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/wordpress.nginx /etc/nginx/sites-enabled/wordpress.nginx

# rename vhost server name to hostname
echo "nginx vhost conf..."
sed -i "s/%%hostname%%/${HOSTNAME}/" /etc/nginx/sites-available/wordpress.nginx

# php version for fpm
sed -i "s/%%php_version%%/${PHP_VERSION}/" /etc/nginx/php.nginx
