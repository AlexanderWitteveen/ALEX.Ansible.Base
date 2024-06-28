#!/bin/bash

ipaddress=$1
hostname=$2
localuserssh=$3

keystring=$(ssh-keyscan -H -t ecdsa $hostname 2>/dev/null)
if [[ -z "$keystring" ]]; then
  echo "Warning: Server not online"
else
  ssh-keygen -R $hostname -f "$localuserssh/known_hosts"
  echo $keystring >> "$localuserssh/known_hosts"
fi

keystring=$(ssh-keyscan -H -t ecdsa $ipaddress 2>/dev/null)
if [[ -z "$keystring" ]]; then
  echo "Error: Server not online"
  exit 2
else
  ssh-keygen -R $ipaddress -f "$localuserssh/known_hosts"
  echo $keystring >> "$localuserssh/known_hosts"
fi

