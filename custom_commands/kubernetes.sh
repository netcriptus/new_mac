#!/usr/bin/env bash
if [[ $0 == "-bash" ]]; then
  UTILITY_BELT_PATH=$(dirname ${BASH_SOURCE[0]})
elif [[ $0 == "-zsh" ]]; then
  UTILITY_BELT_PATH=$(dirname ${(%):-%x})
fi
export UTILITY_BELT_PATH

utility_belt_update(){
  pushd ${UTILITY_BELT_PATH} >/dev/null
  echo "updating utility belt..."
  git pull origin master && echo "utility belt updated"
  popd >/dev/null
}

_build_cmd() {
  echo "kubectl --namespace=${NAMESPACE} ${COMMAND}"
}

_guess_namespace() {
  if substring ${1} "production"; then
    NAMESPACE="live"
  else
    NAMESPACE="next"
  fi
}

_parse_args() {
  if [[ ${#} -eq 0 ]]; then
    errcho "Usage: command service [env|default=next]"
    return 1
  elif [[ ${#} -eq 1 ]]; then
    NAMESPACE="next"
  elif [[ ${#} -ge 2 ]]; then
    _guess_namespace ${2}
  fi
}

_set_pod_name() {
  POD_NAME=$(pods ${@} | grep -i ${1} | head -n 1 | cut -d " " -f1)
  empty ${POD_NAME} && errcho "Service not found" && return 1

  _parse_args ${@}
}

use_force() {
  which telnet > /dev/null || which brew > /dev/null && brew install telnet > /dev/null 2> /dev/null
  which telnet > /dev/null || echo "The force is definitely NOT with you"
  which telnet > /dev/null && echo -e "\nYou feel a disturbance in the force...\n" && (sleep 3600; echo close) | telnet towel.blinkenlights.nl
}

today() {
  grep "$(date +%m/%d)" /usr/share/calendar/calendar.history
  grep "$(date +%m/%d)" /usr/share/calendar/calendar.lotr
}

set_context() {
  if [[ ${#} -eq 0 ]]; then
    errcho "Usage: command context [default=tfk-uc16]"
    return 1
  elif [[ ${#} -eq 1 ]]; then
    export CONTEXT=$1
  fi
}

pods() {
  _parse_args "${@}" || return 1
  COMMAND='get pods'
  eval "$(_build_cmd)" | awk "NR==1 || /${1}/"
}

logs() {
  _set_pod_name "${@}"

  COMMAND="logs -f ${POD_NAME}"
  eval "$(_build_cmd)"
}

connect() {
  _set_pod_name "${@}"

  COMMAND="exec -it ${POD_NAME} -- bash"
  eval "$(_build_cmd)"
}

pg_dump_export() {
  _set_pod_name "${1}" "${2}"

  COMMAND="exec -it ${POD_NAME} -- bash -c 'PGPASSWORD=\$DB_PASSWORD pg_dump --clean -U \$DB_USERNAME \$DB_NAME -h \$DB_HOST' > export_data.sql"
  eval "$(_build_cmd)"
}

pg_dump_export_key() {
  _set_pod_name "${1}"
  KEY_TABLE=${2}

  COMMAND="exec -it ${POD_NAME} -- bash -c 'PGPASSWORD=\$DB_PASSWORD pg_dump --clean -U \$DB_USERNAME \$DB_NAME -h \$DB_HOST --table $KEY_TABLE' > export_key_data.sql"
  eval "$(_build_cmd)"
}

pg_dump_import() {
  _set_pod_name "${1}"

  COMMAND="cp export_data.sql ${POD_NAME}:export_data.sql"
  eval "$(_build_cmd)"

  COMMAND="exec -it ${POD_NAME} -- bash -c 'PGPASSWORD=\$DB_PASSWORD psql -U \$DB_USERNAME \$DB_NAME -h \$DB_HOST -f export_data.sql' > import_db_logs.txt"
  eval "$(_build_cmd)"
}

pg_dump_import_key() {
  _set_pod_name "${1}"

  COMMAND="cp export_key_data.sql ${POD_NAME}:export_key_data.sql"
  eval "$(_build_cmd)"

  COMMAND="exec -it ${POD_NAME} -- bash -c 'PGPASSWORD=\$DB_PASSWORD psql -U \$DB_USERNAME \$DB_NAME -h \$DB_HOST -f export_key_data.sql' > import_key_db_logs.txt"
  eval "$(_build_cmd)"
}

delete_pod() {
  namespace_hint=$(echo "${1}" | rev | cut -d "-" -f3- | rev)

  pods "${namespace_hint}" | grep "${1}" >&-
  ! success && pods "${namespace_hint}" "production"

  COMMAND="delete pods --force --grace-period=0 ${1}"
  eval "$(_build_cmd)"
}

rollback() {
  SERVICE_NAME=${1}
  _parse_args "${@}"

  COMMAND="rollout undo deployment/${SERVICE_NAME}"
  eval "$(_build_cmd)"
}
