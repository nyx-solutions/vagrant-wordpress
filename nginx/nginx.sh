#!/usr/bin/env bash

# Start after boot
sudo update-rc.d nginx enable

sudo chown -R vagrant:vagrant /var/log/nginx

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

if [ ! -f /etc/nginx/sites-enabled/wordpress.nginx ]; then
  ln -s /etc/nginx/sites-available/wordpress.nginx /etc/nginx/sites-enabled/wordpress.nginx
fi

# ssl
mkdir -p /etc/nginx/ssl

cp "/vagrant/vagrant-resources/${SSL_CERT_ROOT}" "/etc/nginx/ssl/${SSL_CERT_ROOT}"
cp "/vagrant/vagrant-resources/${SSL_CERT_ROOT_KEY}" "/etc/nginx/ssl/${SSL_CERT_ROOT_KEY}"
cp "/vagrant/vagrant-resources/${SSL_CERT_SITE}" "/etc/nginx/ssl/${SSL_CERT_SITE}"
cp "/vagrant/vagrant-resources/${SSL_CERT_SITE_KEY}" "/etc/nginx/ssl/${SSL_CERT_SITE_KEY}"

# rename vhost server name to hostname
echo "NGINX VHOST CONF..."
sed -i "s/%%hostname%%/${HOSTNAME}/" /etc/nginx/sites-available/wordpress.nginx
sed -i "s/%%ip_address%%/${IP_ADDRESS}/" /etc/nginx/sites-available/wordpress.nginx
sed -i "s/%%cert%%/${SSL_CERT_SITE}/" /etc/nginx/sites-available/wordpress.nginx
sed -i "s/%%cert_key%%/${SSL_CERT_SITE_KEY}/" /etc/nginx/sites-available/wordpress.nginx

# php version for fpm
echo "PHP VERSION..."
sed -i "s/%%php_version%%/${PHP_VERSION}/" /etc/nginx/php.nginx
