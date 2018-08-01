#!/usr/bin/env bash

printf "\n\n\t\033[35;1mTerraform Apply\033[0m\n\n"

terraform get 
terraform init

terraform apply \
  -auto-approve=false \
  -var-file=../../tfvars/packer_ami.tfvars