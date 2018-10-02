
/* data "terraform_remote_state" "vpc" {
  backend = "local"

  config {
    path = "./vpc/terraform.tfstate"
  }
} */

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