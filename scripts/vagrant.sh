#!/bin/bash

set -e
set -x

WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

date | sudo tee /etc/vagrant_box_build_time

PUBLIC_KEY=$(curl -s 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub')
KEY_TYPE=$(echo "$PUBLIC_KEY" | awk '{print $1}')
KEY=$(echo "$PUBLIC_KEY" | awk '{print $2}')

$WRAPPER begin
$WRAPPER set system login user vagrant authentication public-keys vagrant type "$KEY_TYPE"
$WRAPPER set system login user vagrant authentication public-keys vagrant key "$KEY"
$WRAPPER commit
$WRAPPER save
$WRAPPER end

# change vagrant id to 1000
sudo sed -i 's/:x:1001/:x:1000/' /etc/passwd
sudo chown 1000:users /home/vagrant/ -R

# create vagrant group for user vagrant
sudo groupadd vagrant -g 1000
sudo usermod -a -G vagrant vagrant
