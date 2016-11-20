# !/bin/bash

empty() {
    [ -z ${1} ]
}

success() {
    [ ${?} -eq 0 ]
}

substring() {
    [[ "${2}" =~ "${1}" ]]
}
