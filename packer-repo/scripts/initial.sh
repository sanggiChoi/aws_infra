#!/bin/bash

export LANG=en_US.utf8

yum -y update

#add to install package
yum -y htop, vim, git

# Default Time Zone Change
rm -f /etc/localtime
ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime