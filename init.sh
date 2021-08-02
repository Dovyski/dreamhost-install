#!/bin/bash

PHP_BIN="php-8.0"
NODE_VERSION="v14.0.0"

add_to_bash_config(){
  echo $1 >> ~/.bashrc
  echo $1 >> ~/.bash_profile
}

source_bash_config(){
  source ~/.bashrc
  source ~/.bash_profile
}

echo -e "\e[1;33m Prepare .bash_profile \e[0m"

add_to_bash_config 'export PHP_BIN="$PHP_BIN"'
add_to_bash_config 'alias ls="ls --color=auto"'
add_to_bash_config 'alias wget="wget -c"'
add_to_bash_config 'alias ll="ls -la"'
add_to_bash_config 'alias php="php-8.0"'
add_to_bash_config 'alias ..="cd .."'
add_to_bash_config 'alias grep="grep --color=auto"'

source_bash_config

echo -e "\e[1;33m Installing composer \e[0m"
cd ~
mkdir -p ~/.php/composer && cd ~/.php/composer
curl -sS https://getcomposer.org/installer | $PHP_BIN
add_to_bash_config 'export PATH=/home/$USER/.php/composer:$PATH'
source ~/.bash_profile
mv ~/.php/composer/composer.phar ~/.php/composer/composer

echo -e "\e[1;33m Installing node/npm \e[0m"
cd ~
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
add_to_bash_config 'export NVM_DIR="$HOME/.nvm"'
add_to_bash_config '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm'
add_to_bash_config '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion'

source_bash_config

setfattr -n user.pax.flags -v "mr" $NVM_DIR/nvm.sh

# First run will fail, so we supress all the output
nvm install $NODE_VERSION >/dev/null 2>&1
setfattr -n user.pax.flags -v "mr" $(find $NVM_DIR -type f -iname "node" -o -iname "npm" -o -iname "npx")

nvm install $NODE_VERSION

echo -e "\e[1;33m Installed packages \e[0m"
echo -e "\e[1;33m ---------------------------------- \e[0m"
echo -e "composer:\e[1;32m $(composer -V | awk '{print $3}') \e[0m"
echo -e "node:\e[1;32m $(node -v) \e[0m"
echo -e "php:\e[1;32m $(php -v | awk '/^PHP/{print $2}') \e[0m"
