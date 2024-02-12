#!/bin/bash

set -ex

DNS_PORT="${DNS_PORT:-53}"
TTL="${TTL:-3600}"

if [ -z "${MY_DNS_SERVER}" ]
then
  echo "no \$MY_DNS_SERVER provided"
  exit 5
fi

if [ -z "${TARGET_HOST}" ]
then
  echo "no \$TARGET_HOST provided"
  exit 5
fi

set +x
if [ -z "${KEY_BYTES}" ]
then
  echo "no \$KEY_BYTES provided"
  exit 5
fi
set -x

if [[ $TARGET_HOST =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  MY_IP=$TARGET_HOST
else
  MY_IP=$(dig +short $TARGET_HOST)
fi

UPDATE_LIST=""
for DOMAIN in ${DOMAINS//,/ }
do
    UPDATE_LIST="${UPDATE_LIST}\
update delete ${DOMAIN}. A
update add ${DOMAIN}. ${TTL} A ${MY_IP}
send
answer
"
done

NSUPDATE_COMMANDS="\
server ${MY_DNS_SERVER} ${DNS_PORT}
${UPDATE_LIST}\
"

set +x

echo "\
=== === === SENDING === === ===
${NSUPDATE_COMMANDS}
=== === === E/O SENDING === === ==="

nsupdate -y "${KEY_BYTES}" -v <<EOF
${NSUPDATE_COMMANDS}
EOF

