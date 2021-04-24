#!/usr/bin/env bash

if $INSTALL_WORDPRESS; then

  echo "**** INSTALLING WP ${WP_VERSION}"

  cd "${WP_PATH}" || exit 1

  # if wp_version is specified, then add this
  DOWNLOAD_STRING=""

  if [ ! -z "${WP_VERSION}" ]; then
    DOWNLOAD_STRING=" --version={$WP_VERSION}"
  fi

  # download core files
  # downloading wordpress
  sudo -u vagrant -i -- wp core download --path="${WP_PATH}" "${DOWNLOAD_STRING}" --quiet

  # create wp-config.php
  echo 'creating wp-config.php'

  if [ -z "${WP_DB_USER}" ]; then
    WP_DB_USER='root'
  fi

  if [ -z "${WP_DB_PASSWORD}" ]; then
    WP_DB_PASSWORD='root'
  fi

  echo "wp core config --path=${WP_PATH} --dbname=${WP_DB_NAME} --dbuser=${WP_DB_USER} --dbpass=${WP_DB_PASSWORD}"

  sudo -u vagrant -i -- wp core config --path="${WP_PATH}" --dbname="${WP_DB_NAME}" --dbuser="${WP_DB_USER}" --dbpass="${WP_DB_PASSWORD}" --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP

  wp core install --allow-root \
    --path="${WP_PATH}" \
    --url="${HOSTNAME}" \
    --admin_user="${WP_ADMIN_USER}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --title="${WP_SITE_TITLE}" \
    --skip-email
fi
