# !/bin/bash

nuke() {
    # if no name was sent, nuke EVERYBODY!
    if empty ${1}
    then
        dm rm ${VMS}
    else
        # or just nuke the required vm's
        dm rm $1
    fi
    export VMS=`dm ls | cut -d ' ' -f 1 | tail -n +2`
}

vmcreate() {
  dm create --driver vmwarefusion --vmwarefusion-memory-size "4096" --vmwarefusion-cpu-count "4" ${1}
  success && eval $(docker-machine env ${1})
  success && export VMS=`dm ls | cut -d ' ' -f 1 | tail -n +2` && echo "${1} created"
}

rebuild() {
    if empty ${1}
    then
        echo "Rebuild what?"
        return 1
    else
        nuke ${1} && echo "Recreating ${1}..." && vmcreate ${1}
    fi

}

vmrestart() {
    if empty ${1}
    then
        target=${VMS}
    else
        target=${1}
    fi
    dm restart ${target}
    dm regenerate-certs ${target}
    eval $(docker-machine env ${target})
}
