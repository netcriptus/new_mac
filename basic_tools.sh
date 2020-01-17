#!/bin/bash

# install homebrew
echo "#### Installing Homebrew ####"
echo
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "#### Installing basic tools from homebrew ####"
echo
brew tap caskroom/cask
brew install ack git bash-completion coreutils wget\
     pyenv axel
brew cask install docker google-chrome iterm2 keybase slack

echo "#### Installing python 3 ####"
echo
pyenv install 3.8.0
pyenv global 3.8.0

#Install RVM
echo "#### Installing RVM ####"
curl -sSL https://get.rvm.io | bash -s stable
