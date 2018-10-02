module "bastion_devstg" {
  source              = "../../../modules/bastion"

  name                = "devstg"
  vpc_id              = "${data.terraform_remote_state.vpc.devstg_vpc_id}"

  ami                 = "${data.aws_ami.bastion_seoul.id}"             
  availability_zone   = "ap-northeast-2a"
  subnet_id           = "${data.terraform_remote_state.vpc.devstg_vpc_public_subnets_ids[0]}"
  #ingress_cidr_blocks = "${var.office_cidr_blocks}"
  ingress_cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
  keypair_name        = "test"

  tags = {
    Terraform   = "true"
    Environment = "devstg"
  }
}