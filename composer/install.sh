cd ~ || exit 1

curl -sS https://getcomposer.org/installer -o composer-setup.php

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

sudo composer self-update

composer --version

cd /vagrant || exit 1

rm -rf vendor && rm -rf composer.lock

composer install -o
