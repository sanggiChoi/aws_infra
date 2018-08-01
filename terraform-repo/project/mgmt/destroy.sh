#!/bin/bash

printf "\n\n\t\033[35;1mTerraform Destroy\033[0m\n\n"

terraform get 

terraform destroy                     \
  -var-file=../../tfvars/packer_ami.tfvars