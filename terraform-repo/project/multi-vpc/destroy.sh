#!/bin/bash


printf "\n\n\t\033[35;1mTerraform Destroy Bastion\033[0m\n\n"
cd ./bastion && rm -rf .terraform
terraform init
terraform destroy -auto-approve
cd ..

printf "\n\n\t\033[35;1mTerraform Destroy Peering\033[0m\n\n"
cd ./peering && rm -rf .terraform
terraform init
terraform destroy -auto-approve
cd ..

printf "\n\n\t\033[35;1mTerraform Destroy VPC\033[0m\n\n"
cd ./vpc && rm -rf .terraform
terraform init
terraform destroy -auto-approve
cd ..