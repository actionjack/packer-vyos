if [ -z $CHEF_VERSION ]; then
  export CHEF_VERSION='11.10.4-1'
fi

if [ -z $ARCH ]; then
  export ARCH=x86_64
fi

if [ -z $PROC ]; then
  export PROC=amd64
fi

#https://opscode-omnibus-packages.s3.amazonaws.com/debian/6/i686/chef_11.10.4-1.debian.6.0.5_i386.deb

curl http://opscode-omnibus-packages.s3.amazonaws.com/debian/6/${ARCH}/chef_${CHEF_VERSION}.debian.6.0.5_${PROC}.deb -o chef.deb
sudo dpkg -i chef.deb
rm chef.deb

