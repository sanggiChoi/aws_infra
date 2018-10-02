module "bastion_mgmt" {
  source              = "../../../modules/bastion"

  name                = "mgmt"
  vpc_id              = "${data.terraform_remote_state.vpc.mgmt_vpc_id}"

  ami                 = "${data.aws_ami.bastion_seoul.id}"
  availability_zone   = "ap-northeast-2a"
  subnet_id           = "${data.terraform_remote_state.vpc.mgmt_vpc_public_subnets_ids[0]}"
  ingress_cidr_blocks = "${var.office_cidr_blocks}"
  keypair_name        = "test"

  tags = {
    Terraform   = "true"
    Environment = "mgmt"
  }
}