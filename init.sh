#!/bin/bash

PHP_BIN="php-8.0"
NODE_VERSION="v14.0.0"

echo -e "\e[1;33m Prepare .bash_profile \e[0m"

echo 'alias ls="ls -la"' >> ~/.bashrc
echo 'alias php="php-8.0"' >> ~/.bashrc
source ~/.bash_profile

echo -e "\e[1;33m Install composer \e[0m"
cd ~
mkdir -p ~/.php/composer && cd ~/.php/composer
curl -sS https://getcomposer.org/installer | $PHP_BIN
echo 'export PATH=/home/$USER/.php/composer:$PATH' >> ~/.bash_profile
source ~/.bash_profile
mv ~/.php/composer/composer.phar ~/.php/composer/composer

echo -e "\e[1;33m Install node/npm \e[0m"
cd ~
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bash_profile
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm' >> ~/.bash_profile
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> ~/.bash_profile
source ~/.bashrc && source ~/.bash_profile
setfattr -n user.pax.flags -v "mr" $NVM_DIR/nvm.sh
nvm install $NODE_VERSION
setfattr -n user.pax.flags -v "mr" $(find $NVM_DIR -type f -iname "node" -o -iname "npm" -o -iname "npx")
nvm install $NODE_VERSION

echo -e "\e[1;33m Status: \e[0m"
composer -V
node -v
php -v