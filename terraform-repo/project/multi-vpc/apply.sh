#!/bin/bash

printf "\n\n\t\033[35;1mTerraform Apply VPC\033[0m\n\n"

cd ./vpc && rm -rf .terraform
terraform init
terraform apply -auto-approve
cd ..

sleep 5
printf "\n\n\t\033[35;1mTerraform Apply VPC Peering\033[0m\n\n"
cd ./peering && rm -rf .terraform
terraform init
terraform apply -auto-approve
cd ..

sleep 5
printf "\n\n\t\033[35;1mTerraform Apply Bastion\033[0m\n\n"
cd ./bastion && rm -rf .terraform
terraform init
terraform apply -auto-approve
cd ..