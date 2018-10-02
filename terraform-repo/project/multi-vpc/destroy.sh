#!/bin/bash


printf "\n\n\t\033[35;1mTerraform Destroy Bastion\033[0m\n\n"
cd ./bastion
terraform init
terraform destroy
cd ..

printf "\n\n\t\033[35;1mTerraform Destroy Peering\033[0m\n\n"
cd ./peering
terraform init
terraform destroy
cd ..

printf "\n\n\t\033[35;1mTerraform Destroy VPC\033[0m\n\n"
cd ./vpc
terraform init
terraform destroy
cd ..