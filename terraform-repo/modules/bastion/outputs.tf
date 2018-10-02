output "instance_id" {
  description = "Bastion EC2 instance ID"
  value       = "${aws_instance.bastion_vm.id}"
}

output "bastion_sg_id" {
  description = "Bastion에 접속하는 SG ID"
  value       = ["${aws_security_group.default.id}"]
}

output "ssh_from_bastion_sg_id" {
  description = "Bastion을 통한 SSH 연결을 허용하는 SG ID"
  value       = ["${aws_security_group.ssh_from_bastion.id}"]
}

output "eip_id" {
  description = "Bastion에 할당된 EIP ID"
  value       = "${aws_eip.bastion_ip.id}"
}

output "bastion_public_ip" {
  description = "Bastion에 할당된 Public IP"
  value       = "${aws_eip.bastion_ip.public_ip}"
}

output "bastion_private_ip" {
  description = "Bastion에 할당된 Private IP"
  value       = "${aws_eip.bastion_ip.private_ip}"
}