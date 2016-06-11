#!/bin/bash

deploy(){
    empty ${1} && errcho "No target to deploy. Aborting." && return 1

    CHERRYPICKED=0

    pushd ${WD}/dubsmash-${1}
    git checkout staging && git pull origin staging && \
    git checkout master && git pull origin master && \
    git fetch -p
    git branch

    ! success && return

    echo -n "Enter hash (blank to stop) > "
    while read line; do
      empty ${line} && break  # stop reading if no hash is provided
      CHERRYPICKED=1
      git cherry-pick ${line}
      ! success && return
      echo -n "Enter hash (blank to stop) > "
    done

    [ ${CHERRYPICKED} -ne 1 ] && return 0

    git pull origin master && git push origin master && \
    git checkout staging && \
    git pull origin staging && git pull origin master && git push origin staging

    echo "${1} deployed."
    popd
}
