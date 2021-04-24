#!/usr/bin/env bash

. /vagrant/vagrant-config/environment.sh

echo "*****DB NAME IS ${WP_DB_NAME}"

if [ ! -z "${WP_DB_NAME}" ]; then
  NOW=$(date +"%Y_%m_%d-%H-%M-%S")
  DB_DUMP_FILE="${WP_DB_NAME}_${NOW}.sql"

  echo "**** DUMPING DATABASE BEFORE DESTROY"
  echo "**** DUMP FILE: /vagrant/vagrant-resources/dumps/${DB_DUMP_FILE}"

  if [ ! -d /vagrant/vagrant-resources/dumps ]; then
    mkdir -p /vagrant/vagrant-resources/dumps
  fi

  mysqldump --defaults-extra-file=~/.mysql_root.cnf "${WP_DB_NAME}" >"/vagrant/vagrant-resources/dumps/${DB_DUMP_FILE}"

  if [ ! "$?" -eq 0 ]; then
    echo "***** DATABASE DUMP FAILED - YOU MAY WISH TO ABORT VAGRANT DESTROY."
    echo "***** CHECK vagrant-wordpress/dumps/error.log FOR MORE INFO."
  fi
fi
