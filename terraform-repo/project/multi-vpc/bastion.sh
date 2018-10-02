#!/bin/bash

cd ./bastion

terraform refresh

bastion_ip=$(terraform output --json | jq -r ".bastion_mgmt_public_ip.value")
echo "SSHing onto Bastion located at: $bastion_ip"
ssh -i ../ssh_keys/test.pem ec2-user@$bastion_ip

cd ..