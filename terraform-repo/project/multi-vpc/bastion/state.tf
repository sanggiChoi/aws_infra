terraform {
  backend "s3" {
    bucket = "grumbler.terraform.state"
    key = "bastion/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "TerraformStateLock"
    acl = "bucket-owner-full-control"
  }
}