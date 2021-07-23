#!/bin/bash

echo 'Prepare .bash_profile'

echo 'alias ls="ls -la"' >> ~/.bashrc
echo 'alias php="php-8.0"' >> ~/.bashrc
source ~/.bash_profile

echo 'Install composer'
cd ~
mkdir -p ~/.php/composer && cd ~/.php/composer
curl -sS https://getcomposer.org/installer | php-8.0
echo 'export PATH=/home/$USER/.php/composer:$PATH' >> ~/.bash_profile
. ~/.bash_profile
mv ~/.php/composer/composer.phar ~/.php/composer/composer

echo 'Install node/npm'
cd ~
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc && . ~/.bash_profile
setfattr -n user.pax.flags -v "mr" $NVM_DIR/nvm.sh
nvm install v14.0.0
setfattr -n user.pax.flags -v "mr" $(find $NVM_DIR -type f -iname "node" -o -iname "npm" -o -iname "npx")
nvm install v14.0.0

echo 'Status'
composer -v
node -v
php -v