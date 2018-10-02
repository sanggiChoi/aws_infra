#!/bin/bash

printf "\n\n\t\033[35;1mTerraform Apply VPC\033[0m\n\n"

cd ./vpc
terraform init
terraform apply 
cd ..

sleep 5
printf "\n\n\t\033[35;1mTerraform Apply VPC Peering\033[0m\n\n"
cd ./peering
terraform init
terraform apply
cd ..

sleep 5
printf "\n\n\t\033[35;1mTerraform Apply Bastion\033[0m\n\n"
cd ./bastion
terraform init
terraform apply
cd ..