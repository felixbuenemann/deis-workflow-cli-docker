#!/bin/bash
set -e

GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-ssh -oStrictHostKeyChecking=no}"
if [[ ! -z "$DEIS_USERNAME" ]] && [[ ! -z "$DEIS_CONTROLLER" ]] && [[ ! -z "$DEIS_TOKEN" ]]; then
mkdir -p ~/.deis
cat <<EOF > ~/.deis/${DEIS_PROFILE:-client}.json
{
  "username": "${DEIS_USERNAME}",
  "ssl_verify": ${DEIS_SSL_VERIFY:-true},
  "controller": "${DEIS_CONTROLLER}",
  "token": "${DEIS_TOKEN}",
  "response_limit": ${DEIS_RESPONSE_LIMIT:-100}
}
EOF
elif [[ ! -z "$DEIS_USERNAME" ]] && [[ ! -z "$DEIS_CONTROLLER" ]] && [[ ! -z "$DEIS_PASSWORD" ]]; then
  deis auth:login "${DEIS_CONTROLLER}" \
    --username="${DEIS_USERNAME}" \
    --password="${DEIS_PASSWORD}" \
    --ssl-verify="${DEIS_SSL_VERIFY:-true}"
fi
if [[ ! -z "${DEIS_SSH_KEY:-$SSH_KEY}" ]]; then
  eval `ssh-agent -s` > /dev/null
  echo "${DEIS_SSH_KEY:-$SSH_KEY}" | ssh-add - 2> /dev/null
fi
exec "$@"
