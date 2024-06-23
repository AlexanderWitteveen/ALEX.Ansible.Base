#!/bin/bash

ipaddress=$1
username=$2
path=$3

result=$( expect -f $(dirname "$0")/test.python.expect "$ipaddress" "$username" "$path" )
if [[ "$?" != "0" ]]; then 
    echo "**** Error: Expect failed"
fi

echo $result | grep "TRUE" > /dev/null
if [ "$?" == "0" ]; then
    echo $path
fi

