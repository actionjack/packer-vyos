#!/bin/bash

set -e
set -x

WRAPPER=/opt/vyatta/sbin/vyatta-cfg-cmd-wrapper

$WRAPPER begin
if [ "$vyatta_repo_dev" == 'true' ]; then 
  $WRAPPER set system package repository daisy url 'http://packages.vyatta.com/vyatta-dev/daisy/unstable'
  $WRAPPER set system package repository daisy distribution 'daisy'
  $WRAPPER set system package repository daisy components 'main'
fi

if [ $vyatta_repo_4people == 'true' ]; then
  $WRAPPER set system package repository vyatta4people url 'http://packages.vyatta4people.org/debian'
  $WRAPPER set system package repository vyatta4people distribution 'experimental'
  $WRAPPER set system package repository vyatta4people components 'main'
fi

if [ $vyatta_repo_debian == 'true' ]; then
  $WRAPPER set system package repository squeeze url 'http://mirrors.kernel.org/debian'
  $WRAPPER set system package repository squeeze distribution 'squeeze'
  $WRAPPER set system package repository squeeze components 'main contrib non-free'
fi

$WRAPPER commit
$WRAPPER save
$WRAPPER end

sudo aptitude -y update

# remove extra ttys 
sudo sed -i -e 's,^.*:/sbin/getty\s\+.*\s\+tty[2-6],#\0,' /etc/inittab

# Tweak sshd to prevent DNS resolution (speed up logins)
sudo sed -i 's/UseDNS yes/UseDNS no/' /etc/ssh/sshd_config

# Install NFS client 
sudo apt-get -y install nfs-common

# Remove 5s grub timeout to speed up booting
cat <<EOF | sudo tee /etc/default/grub
GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_CMDLINE_LINUX_DEFAULT="quiet"
EOF

sudo update-grub