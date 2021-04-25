#!/usr/bin/env bash

if [ ! -z "${WP_DB_NAME}" ]; then
  echo "**** CREATING DATABASE"
  echo "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME};"

  mysql --defaults-extra-file=~/.mysql_root.cnf -e "CREATE DATABASE IF NOT EXISTS ${WP_DB_NAME};"

  if [ ! -z "${WP_DB_USER}" ]; then
    if [ "${USER}" != "root" ]; then
      echo "**** ADDING CUSTOM USER"
      echo "GRANT ALL ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'localhost' IDENTIFIED BY '${WP_DB_PASSWORD}'"

      mysql --defaults-extra-file=~/.mysql_root.cnf -e "GRANT ALL ON ${WP_DB_NAME}.* TO '${WP_DB_USER}'@'localhost' IDENTIFIED BY '${WP_DB_PASSWORD}'"
    fi
  fi
else
  echo "**** NO DATABASE NAME SPECIFIED - SKIPPING DB CREATION"
fi
