cd ~ || exit 1

curl -sS https://getcomposer.org/installer -o composer-setup.php

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

sudo composer self-update

sudo runuser vagrant -c "composer --version"

cd /vagrant || exit 1

rm -rf vendor && rm -rf composer.lock

sudo runuser vagrant -c "cd /vagrant && composer install -o"
