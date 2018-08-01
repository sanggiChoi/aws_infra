#!/bin/bash

export LANG=en_US.utf8

sudo yum update -y

#add to install package
sudo yum -y install htop, vim, git

# Default Time Zone Change
rm -f /etc/localtime
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime