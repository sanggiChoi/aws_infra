/* terraform {
  backend "local" {
    path = "./peering/terraform.tfstate"
  }
} */

terraform {
  backend "s3" {
    bucket = "grumbler.terraform.state"
    key = "peering/terraform.tfstate"
    region = "ap-northeast-2"
    encrypt = true
    dynamodb_table = "TerraformStateLock"
    acl = "bucket-owner-full-control"
  }
}