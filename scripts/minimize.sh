#!/bin/sh

set -e
set -x

# Zero out the free space to reduce final image size
sudo dd if=/dev/zero of=/EMPTY bs=1M || :
sudo rm -f /EMPTY