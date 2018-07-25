provider "aws" {
  alias  = "seoul"
  region = "ap-northeast-2"
}

# module 키워드를 사용해서 vpc module을 정의한다.
module "vpc" {
  #source는 variables.tf, main.tf, output.tf 파일이 위치한 디렉터리 경로를 넣어준다.
  source = "../../modules/vpc"

  name = "${var.name}"

  # VPC의 CIDR block을 정의 한다.
  cidr = "10.193.224.0/20"

  azs = ["ap-northeast-2a", "ap-northeast-2c"]

  # VPC의 Public Subnet CIDR block을 정의 한다.
  public_subnets = ["10.193.234.0/24", "10.193.235.0/24"]

  # VPC의 Private Web Subnet CIDR block을 정의한다.
  private_web_subnets = ["10.193.224.0/24", "10.193.225.0/24"]

  # VPC의 Private Web Subnet CIDR block을 정의한다.
  private_was_subnets = ["10.193.229.0/24", "10.193.230.0/24"]

  # VPC의 Private DB Subnet CIDR block을 정의한다.
  private_db_subnets = ["10.193.238.0/24", "10.193.239.0/24"]

  # VPC module이 생성하는 모든 리소스에 기본으로 입력될 Tag를 정의힌다.
  tags = {
    Terraform   = "true"
    Environment = "${var.name}"
  }
}

data "aws_ami" "base_ami_seoul" {
  provider = "aws.seoul"

  most_recent = true

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "tag:type"
    values = ["${var.base-ami-tag}"]
  }
}

module "bastion" {
  source = "../../modules/bastion"

  name   = "${var.name}"
  vpc_id = "${module.vpc.vpc_id}"

  ami                 = "${data.aws_ami.base_ami_seoul.id}"
  availability_zone   = "ap-northeast-2a"
  subnet_id           = "${module.vpc.public_subnets_ids[0]}"
  ingress_cidr_blocks = "${var.office_cidr_blocks}"
  keypair_name        = "SE2-POC"

  tags = {
    Terraform   = "true"
    Environment = "mgmt"
  }
}
