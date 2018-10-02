# module 키워드를 사용해서 vpc module을 정의한다.
module "vpc_prd" {

  source = "../../../modules/vpc"

  name = "prd"

  # VPC의 CIDR block을 정의 한다.
  cidr = "10.2.0.0/16"

  azs = ["ap-northeast-2a", "ap-northeast-2c"]

  # VPC의 Public Subnet CIDR block을 정의 한다.
  public_subnets = ["10.2.0.0/24", "10.2.1.0/24"]

  # VPC의 Private WEB Subnet CIDR block을 정의한다.
  private_web_subnets = ["10.2.2.0/24", "10.2.3.0/24"]

  # VPC의 Private WAS Subnet CIDR block을 정의한다.
  private_was_subnets = ["10.2.4.0/24", "10.2.5.0/24"]

  # VPC의 Private DB Subnet CIDR block을 정의한다.
  private_db_subnets = ["10.2.6.0/24", "10.2.7.0/24"]

  # VPC module이 생성하는 모든 리소스에 기본으로 입력될 Tag를 정의힌다.
  tags = {
    Terraform   = "true"
    Environment = "prd"
  }
}

/* module "bastion_prd" {
  source              = "../../../modules/bastion"

  name                = "prd"
  vpc_id              = "${module.vpc_prd.vpc_id}"

  ami                 = "${data.aws_ami.bastion_seoul.id}"
  availability_zone   = "ap-northeast-2a"
  subnet_id           = "${module.vpc_prd.public_subnets_ids[0]}"
  #ingress_cidr_blocks = "${var.office_cidr_blocks}"
  ingress_cidr_blocks = ["10.0.0.0/24", "10.0.1.0/24"]
  keypair_name        = "test"

  tags = {
    Terraform   = "true"
    Environment = "prd"
  }
} */
