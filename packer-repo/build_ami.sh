#!/bin/bash

set -e

packer build \
  -var-file=./templates/seoul_env.json ./templates/base_template.json | tee ./logs/packer_output.log

cat ./logs/packer_output.log | tail -n 2 \
  | sed '$d' \
  | sed "s/ap-northeast-2: /packer_built_bastion_ami = \"/" \
  | sed -e 's/[[:space:]]*$/\"/' > ../terraform-repo/tfvars/packer_ami.tfvars

cat ../terraform-repo/tfvars/packer_ami.tfvars