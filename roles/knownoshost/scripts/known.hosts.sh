#!/bin/bash

ipaddress=$1
hostname=$2
localuserssh=$3

cp "$localuserssh/known_hosts" "$localuserssh/known_hosts.bak"

ssh-keygen -R $hostname -f "$localuserssh/known_hosts" 2>/dev/null
keystring=$(ssh-keyscan -H -t ecdsa $hostname 2>/dev/null)
if [[ -z "$keystring" ]]; then
  echo "Warning: Server not online"
else
  echo $keystring >> "$localuserssh/known_hosts"
fi

ssh-keygen -R $ipaddress -f "$localuserssh/known_hosts" 2>/dev/null
keystring=$(ssh-keyscan -H -t ecdsa $ipaddress 2>/dev/null)
if [[ -z "$keystring" ]]; then
  echo "Error: Server not online"
  exit 2
else
  echo $keystring >> "$localuserssh/known_hosts"
fi

rm "$localuserssh/known_hosts.old" 2>/dev/null
