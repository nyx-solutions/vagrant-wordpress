#!/usr/bin/env bash

if $INIT_WORDPRESS; then
  chmod +x /vagrant/init

  cd /vagrant || exit 1

  sudo runuser vagrant -c "cd /vagrant && python3.8 ./init -e vagrant"
fi
