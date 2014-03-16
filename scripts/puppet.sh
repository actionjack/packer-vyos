#!/bin/bash

set -e
set -x

if [ -z $PUPPET_VERSION ]; then
  export PUPPET_VERSION=3.4.3-1puppetlabs1
fi 

WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

$WRAPPER begin
$WRAPPER set system package repository puppetlabs components 'main dependencies'
$WRAPPER set system package repository puppetlabs distribution 'squeeze'
$WRAPPER set system package repository puppetlabs url 'http://apt.puppetlabs.com'
$WRAPPER commit
$WRAPPER save
$WRAPPER end

wget http://apt.puppetlabs.com/pubkey.gpg -O - | sudo apt-key add -
#sudo apt-key adv --recv-key --keyserver pool.sks-keyservers.net 4BD6EC30

sudo apt-get update -y

# Install puppet/facter
sudo apt-get install -y puppet=$PUPPET_VERSION puppet-common=$PUPPET_VERSION
sudo sed -i -re "/\[main\]/ apluginsync = true" /etc/puppet/puppet.conf;