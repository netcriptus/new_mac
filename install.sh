#!/bin/bash

REPO_URL=https://raw.githubusercontent.com/netcriptus/new_mac/master
CUSTOM_SCRIPTS='shortcuts'

install () {
  curl ${REPO_URL}/${1}.sh | bash
}

rcopy () {
  curl ${REPO_URL}/config_files/${1} > ${HOME}/${2}
}

[[ -z ${EDITOR} ]] && EDITOR='atom'

# Create folder for custom scripts.
mkdir -p ${HOME}/bin

# Create projects folder
mkdir -p ${HOME}/projects

install basic_tools

# Copy custom scripts
for script in ${CUSTOM_SCRIPTS}; do
  curl ${REPO_URL}/custom_commands/${script}.sh -o ${HOME}/bin/${script}.sh
done

# Copy gitconfig
rcopy base_gitconfig .gitconfig

# Copy terminal settings
rcopy com.googlecode.iterm2.plist Library/Preferences/com.googlecode.iterm2.plist

# Copy base .profile
rcopy base_profile .profile
source ${HOME}/.profile

# Ensure go folder exists
mkdir -p ${WD}/go

install ${EDITOR}
