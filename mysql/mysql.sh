#!/usr/bin/env bash

cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf.default

sed -i 's/bind-address[[:space:]]\+= 127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

echo "[client]
user = root
password = ${MYSQL_ROOT_PASSWORD}
host = localhost
" >~/.mysql_root.cnf
