#!/bin/bash

FLAG_FILE=/etc/hostname.done

if [ ! -e "$FLAG_FILE" ]; then
  echo "$1" > /etc/hostname
  hostname -F /etc/hostname
  ip addr show eth0 | grep -Po 'inet \K[\d.]+' | while read ip; do echo "$ip $1" >> /etc/hosts; done
  ln -sf /usr/share/zoneinfo/EST /etc/localtime
  apt-get update && apt-get upgrade -y
  touch /etc/hostname.done
fi
