#!/bin/bash

# install homebrew
echo "#### Installing Homebrew ####"
echo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "#### Installing basic tools from homebrew ####"
echo
brew tap caskroom/cask
brew install ack git bash-completion coreutils keybase wget pyenv axel
brew cask install docker google-chrome iterm2

echo "#### Installing python 3 ####"
echo
pyenv install 3.6.1
pyenv global 3.6.1

#Install RVM
echo "#### Installing RVM ####"
curl -sSL https://get.rvm.io | bash -s stable

# install virtualenv and virtualenvwrapper
echo "#### Installing virtualenvwrapper ####"
sudo pip3 install virtualenv virtualenvwrapper isort ipython

# Install Go 1.6
echo "#### Installing GVM and golang ####"
echo
bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer) &&\
gvm install go1.4 && gvm use go1.4 &&\  # go1.6 depends on go1.4
gvm install go1.6 && gvm use go1.6
