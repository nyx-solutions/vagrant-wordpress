#!/usr/bin/env bash

if [ ! -z "${WP_DB_NAME}" ] && $IMPORT_DATABASE; then
  NUMBER_OF_SQL_FILES=$(find /vagrant/vagrant-resources -maxdepth 1 -name '*.sql' | wc -l)

  case "${NUMBER_OF_SQL_FILES}" in
  0)
    echo "**** NO SQL FILE FOUND - CANNOT IMPORT"
    ;;
  1)
    echo "**** SQL FILE FOUND - PROCEEDING WITH IMPORT"

    WP_DB_DUMP_FILE=$(find /vagrant/vagrant-resources -maxdepth 1 -name '*.sql')

    echo "**** IMPORT FILENAME IS: ${WP_DB_DUMP_FILE}"

    mysql --defaults-extra-file=~/.mysql_root.cnf "${WP_DB_NAME}" <"${WP_DB_DUMP_FILE}"

    if [ ! -z "${IMPORT_SITE_DOMAIN}" ]; then
      echo "**** WP-CLI SEARCH AND REPLACE"

      wp --path="${WP_PATH}" --allow-root search-replace "${IMPORT_SITE_DOMAIN}" "${HOSTNAME}"
    fi

    ;;
  *)
    echo "**** MULTIPLE SQL FILES FOUND - ABORTING IMPORT"
    ;;
  esac
else
  echo "**** NO DATABASE NAME SPECIFIED - SKIPPING DB IMPORT"
fi
