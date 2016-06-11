#!/bin/bash

REPO_URL=https://raw.githubusercontent.com/netcriptus/new_mac/master
CUSTOM_SCRIPTS='shortcuts deploy vm_manager'

install () {
  curl ${REPO_URL}/${1}.sh | bash
}

[[ -z ${EDITOR} ]] && EDITOR='atom'

# Create folder for custom scripts.
mkdir -p ${HOME}/bin

#Create projects folder
mkdir -p ${HOME}/projects

install basic_tools

# Copy custom scripts
for script in ${CUSTOM_SCRIPTS}; do
  curl ${REPO_URL}/${script}.sh -o ${HOME}/bin/${script}.sh
done

# Copy base .profile
curl ${REPO_URL}/base_profile > ${HOME}/.profile
source ${HOME}/.profile

# Ensure go folder exists
mkdir -p ${WD}/go

install ${EDITOR}
