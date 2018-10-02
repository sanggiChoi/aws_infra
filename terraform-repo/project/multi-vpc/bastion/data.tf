data "aws_ami" "bastion_seoul"{
  #provider = "aws.seoul"

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

variable "office_cidr_blocks" {
  type = "list"

  default = [
    "0.0.0.0/0",
  ] # 이 값은 실제 접속을 허용할 IP를 넣어야 함
}

variable "base-ami-tag" {
  description = "base-ami-tag"
  default     = "base-ami-packer"
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "grumbler.terraform.state"
    key = "vpc/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "TerraformLock"
    acl = "bucket-owner-full-control"
  }
}