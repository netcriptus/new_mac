#!/bin/bash

# install homebrew
echo "#### Installing Homebrew ####"
echo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "#### Installing basic tools from homebrew ####"
echo
brew tap caskroom/cask
brew install ack git bash-completion coreutils keybase wget python3
brew cask install docker google-chrome iterm2

# install virtualenv and virtualenvwrapper
sudo pip install virtualenv virtualenvwrapper

# Install Go 1.6
echo "#### Installing GVM and golang ####"
echo
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
gvm install go1.4 && gvm use go1.4 &&\
gvm install go1.6 && gvm use go1.6
