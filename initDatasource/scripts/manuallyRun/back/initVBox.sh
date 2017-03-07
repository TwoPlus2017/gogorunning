#!/bin/bash

yum install kernel-devel 
yum install kernel-headers.x86_64

export KERN_DIR=/usr/src/kernels/$(uname -r)

if [ "$(uname -r)" -ne "$(ls /usr/src/kernels/)" ]; then
  ln -fs /usr/src/kernels/$(uname -r) /usr/src/kernels/$(ls /usr/src/kernels/)
fi

/media/VBOXADDITIONS_5.0.26_108824/VBoxLinuxAdditions.run
