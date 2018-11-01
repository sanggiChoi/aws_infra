#!/bin/bash

export LANG=en_US.utf8

# ebs mount
sudo mkfs -t ext4 /dev/xvdb
sudo mkdir -p /logs
sudo mount /dev/xvdb /logs
sudo echo /dev/xvdb /logs ext4 defaults,nofail 0 2 >> /etc/fstab

# sudo yum update -y

# #add to install package
# sudo yum -y install htop, vim, git

# # Default Time Zone Change
# rm -f /etc/localtime
# ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime