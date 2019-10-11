#!/bin/bash

if [ -z "$1" ] ; then
   echo "you didn't provide and argument"
   exit 0;
fi
   
status=$(systemctl status httpd | grep Active | awk '{print $2}')
inactive="inactive"

if [ $status == $inactive ]; then
echo "noooo000 if is off"
else 
  echo "My status is $status"
fi
