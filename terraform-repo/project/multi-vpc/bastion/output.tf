output "bastion_devstg_public_ip" {
   value = "${module.bastion_devstg.bastion_public_ip}"
}

output "bastion_devstg_private_ip" {
   value = "${module.bastion_devstg.bastion_private_ip}"
}

output "bastion_mgmt_public_ip" {
   value = "${module.bastion_mgmt.bastion_public_ip}"
}

output "bastion_mgmt_private_ip" {
   value = "${module.bastion_mgmt.bastion_private_ip}"
}

output "bastion_prd_public_ip" {
   value = "${module.bastion_prd.bastion_public_ip}"
}

output "bastion_prd_private_ip" {
   value = "${module.bastion_prd.bastion_private_ip}"
}