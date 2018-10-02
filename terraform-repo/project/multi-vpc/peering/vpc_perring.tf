module "vpc_peering_devstg" {
  source           = "git::https://github.com/cloudposse/terraform-aws-vpc-peering.git?ref=master"
  namespace        = "multi_vpc"
  stage            = "mgmt_devstg"
  name             = "cluster"
  requestor_vpc_id = "${data.terraform_remote_state.vpc.mgmt_vpc_id}"
  acceptor_vpc_id  = "${data.terraform_remote_state.vpc.devstg_vpc_id}"
}

module "vpc_peering_prd" {
  source           = "git::https://github.com/cloudposse/terraform-aws-vpc-peering.git?ref=master"
  namespace        = "multi_vpc"
  stage            = "mgmt_prd"
  name             = "cluster"
  requestor_vpc_id = "${data.terraform_remote_state.vpc.mgmt_vpc_id}"
  acceptor_vpc_id  = "${data.terraform_remote_state.vpc.prd_vpc_id}"
}