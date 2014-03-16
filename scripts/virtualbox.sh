#!/bin/bash

set -e
set -x
if [ -z $PROC1 ]; then
  export PROC1=amd64
fi

if [ -z $PROC2 ]; then
  export PROC2=amd64
fi

sudo aptitude -y install build-essential
sudo aptitude -y install dkms
sudo aptitude -y install linux-vyatta-kbuild

# Uncomment this if you want to install Guest Additions with support for X
#sudo aptitude -y install xserver-xorg

sudo ln -s /usr/src/linux-image/debian/build/build-${PROC1}-none-${PROC2}-vyatta "/lib/modules/$(uname -r)/build"

sudo mount -o loop ~/VBoxGuestAdditions.iso /mnt/
yes | sudo /mnt/VBoxLinuxAdditions.run || :
sudo umount /mnt/
rm -f ~/VBoxGuestAdditions.iso