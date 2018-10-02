# module 키워드를 사용해서 vpc module을 정의한다.

module "vpc_mgmt" {

  source = "../../../modules/vpc"

  name = "mgmt"

  # VPC의 CIDR block을 정의 한다.
  cidr = "10.0.0.0/16"

  azs = ["ap-northeast-2a", "ap-northeast-2c"]

  # VPC의 Public Subnet CIDR block을 정의 한다.
  public_subnets = ["10.0.0.0/24", "10.0.1.0/24"]

  # VPC의 Private WEB Subnet CIDR block을 정의한다.
  private_web_subnets = ["10.0.2.0/24", "10.0.3.0/24"]

  # VPC의 Private WAS Subnet CIDR block을 정의한다.
  private_was_subnets = ["10.0.4.0/24", "10.0.5.0/24"]

  # VPC의 Private DB Subnet CIDR block을 정의한다.
  private_db_subnets = ["10.0.6.0/24", "10.0.7.0/24"]

  # VPC module이 생성하는 모든 리소스에 기본으로 입력될 Tag를 정의힌다.
  tags = {
    Terraform   = "true"
    Environment = "mgmt"
  }
}

/* module "bastion_mgmt" {
  source              = "../../../modules/bastion"

  name                = "mgmt"
  vpc_id              = "${module.vpc_mgmt.vpc_id}"

  ami                 = "${data.aws_ami.bastion_seoul.id}"
  availability_zone   = "ap-northeast-2a"
  subnet_id           = "${module.vpc_mgmt.public_subnets_ids[0]}"
  ingress_cidr_blocks = "${var.office_cidr_blocks}"
  keypair_name        = "test"

  tags = {
    Terraform   = "true"
    Environment = "mgmt"
  }
} */