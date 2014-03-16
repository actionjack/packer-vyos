#!/bin/bash

set -e
set -x
  
# Clean up
sudo apt-get -y remove linux-vyatta-kbuild build-essential
  
WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

if [ "$vyatta_repo_dev" == 'true' ]; then
  $WRAPPER begin
  $WRAPPER delete system package repository daisy
  $WRAPPER commit
  $WRAPPER save
  $WRAPPER end
fi

sudo apt-get -y update
sudo apt-get -y autoremove
sudo apt-get -y clean


#Clean up tmp
sudo rm -rf /tmp/*

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
sudo rm /var/lib/dhcp3/*