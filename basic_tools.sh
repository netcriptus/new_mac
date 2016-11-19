#!/bin/bash

# install homebrew
echo "#### Installing Homebrew ####"
echo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/cask
brew install ack git bash-completion coreutils keybase wget
brew cask install docker google-chrome

# install easy_install and pip
echo "#### Installing pip ####"
echo
curl https://bootstrap.pypa.io/ez_setup.py -o - | python
sudo easy_install pip

# install virtualenv and virtualenvwrapper
sudo pip install virtualenv virtualenvwrapper

# Install Go 1.6
echo "#### Installing GVM and golang ####"
echo
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.4 && gvm use go1.4 &&\
gvm install go1.6 && gvm use go1.6
