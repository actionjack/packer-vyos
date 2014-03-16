#!/bin/bash
packer build -only=virtualbox-iso vyos-1.0.2-i386.json
packer build -only=virtualbox-iso vyos-1.0.2-amd64.json
packer build -only=virtualbox-iso vyatta-core-6.6R1-amd64.json
packer build -only=virtualbox-iso vyatta-core-6.6R1-i386.json
