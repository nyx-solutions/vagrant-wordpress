#!/usr/bin/env bash

if [ -f /usr/local/bin/wp ]; then
  echo "**** UPDATING WP-CLI"

  sudo wp cli update --allow-root --yes
else
  echo "**** INSTALLING WP-CLI"

  cd ~/ || exit

  curl -Os https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

  chmod +x wp-cli.phar

  sudo mv wp-cli.phar /usr/local/bin/wp
fi

WPCLI_DEFAULTS_FOLDER='/home/vagrant/.wp-cli'

if [ ! -d "${WPCLI_DEFAULTS_FOLDER}" ]; then
  echo "**** ADDING WP-CLI DEFAULTS"

  mkdir -p "${WPCLI_DEFAULTS_FOLDER}"

  cp /vagrant/wp-vagrant/wordpress/config.yml "${WPCLI_DEFAULTS_FOLDER}/config.yml"
fi
