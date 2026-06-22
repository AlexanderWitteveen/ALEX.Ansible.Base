#!/bin/bash

ipaddress=$1
localuserssh=$2

cp "$localuserssh/known_hosts" "$localuserssh/known_hosts.bak"
sed "/$ipaddress:/d" "$localuserssh/known_hosts.bak" > "$localuserssh/known_hosts"

# ssh-keygen -R $ipaddress -f "$localuserssh/known_hosts" 2> /dev/null
# keystring=$( ssh-keyscan -H $ipaddress 2> /dev/null )
# if [[ -z "$keystring" ]]; then
#   echo "Error: Server not online"
#   exit 2
# else
#   echo "Changed known hosts for $ipaddress"
#   echo $keystring >> "$localuserssh/known_hosts"
# fi

ssh-keyscan -H $ipaddress >> "$localuserssh/known_hosts" 2> /dev/null
if [[ $(cat "$localuserssh/known_hosts" | grep $ipaddress | wc -l) -eq 0 ]]; then
  echo "Error: Server not online"
  exit 2
else
  echo "Changed known hosts for $ipaddress"
fi

exit 0
