# !/bin/bash

empty() {
    [ -z ${1} ]
}

success() {
    [ ${?} -eq 0 ]
}

substring() {
    occurences=${2//[^${1}]}
    [ ${#occurences} -gt 0 ]
}
