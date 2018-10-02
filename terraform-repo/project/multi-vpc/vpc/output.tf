/* output "bastion_devstg_public_ip" {
   value = "${module.bastion_devstg.bastion_public_ip}"
}

output "bastion_devstg_private_ip" {
   value = "${module.bastion_devstg.bastion_private_ip}"
} */

output "devstg_vpc_id" {
   value = "${module.vpc_devstg.vpc_id}"
}

output "devstg_vpc_public_subnets_ids" {
   value = "${module.vpc_devstg.public_subnets_ids}"
}

/* output "bastion_mgmt_public_ip" {
   value = "${module.bastion_mgmt.bastion_public_ip}"
}

output "bastion_mgmt_private_ip" {
   value = "${module.bastion_mgmt.bastion_private_ip}"
} */

output "mgmt_vpc_id" {
   value = "${module.vpc_mgmt.vpc_id}"
}

output "mgmt_vpc_public_subnets_ids" {
   value = "${module.vpc_mgmt.public_subnets_ids}"
}

/* output "bastion_prd_public_ip" {
   value = "${module.bastion_prd.bastion_public_ip}"
}

output "bastion_prd_private_ip" {
   value = "${module.bastion_prd.bastion_private_ip}"
} */

output "prd_vpc_id" {
   value = "${module.vpc_prd.vpc_id}"
}

output "prd_vpc_public_subnets_ids" {
   value = "${module.vpc_prd.public_subnets_ids}"
}