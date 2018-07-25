# VPC
resource "aws_vpc" "this" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = "${merge(var.tags, map("Name", format("%s-vpc", var.name)))}"
}

# internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  tags = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

# default network ACL
resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_vpc.this.default_network_acl_id}"

  ingress {
    protocol = -1
    rule_no  = 100
    action   = "allow"

    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  subnet_ids = [
    "${aws_subnet.public_subnets.*.id}",
    "${aws_subnet.private_web_subnets.*.id}",
    "${aws_subnet.private_was_subnets.*.id}",
    "${aws_subnet.private_db_subnets.*.id}",
  ]

  tags = "${merge(var.tags, map("Name", format("%s-nacl-default", var.name)))}"
}

# default security group
resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.this.id}"

  ingress {
    protocol    = -1
    self        = true
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.tags, map("Name", format("%s-sg-default", var.name)))}"
}

# public subnet
resource "aws_subnet" "public_subnets" {
  count = "${length(var.public_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-public-%s", var.name, var.azs[count.index])))}"
}

# private subnet
resource "aws_subnet" "private_web_subnets" {
  count = "${length(var.private_web_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.private_web_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-private-web-%s", var.name, var.azs[count.index])))}"
}

resource "aws_subnet" "private_was_subnets" {
  count = "${length(var.private_was_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.private_was_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-private-was-%s", var.name, var.azs[count.index])))}"
}

# private database subnet
resource "aws_subnet" "private_db_subnets" {
  count = "${length(var.private_db_subnets)}"

  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${var.private_db_subnets[count.index]}"
  availability_zone = "${var.azs[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-private_db-%s", var.name, var.azs[count.index])))}"
}

resource "aws_db_subnet_group" "db_subnet_groups" {
  count = "${length(var.private_db_subnets) > 0 ? 1 : 0}"

  name        = "${var.name}"
  description = "Database subnet group for ${var.name}"
  subnet_ids  = ["${aws_subnet.private_db_subnets.*.id}"]
  tags        = "${merge(var.tags, map("Name", format("%s-db_subnet_group", var.name)))}"
}

# EIP for NAT gateway
resource "aws_eip" "nat" {
  count = "${length(var.azs)}"

  vpc = true

  tags = "${merge(var.tags, map("Name", format("%s-nat-ip-%s", var.name, var.azs[count.index])))}"
}

# NAT gateway
resource "aws_nat_gateway" "this" {
  count = "${length(var.azs)}"

  allocation_id = "${aws_eip.nat.*.id[count.index]}"
  subnet_id     = "${aws_subnet.public_subnets.*.id[count.index]}"

  tags = "${merge(var.tags, map("Name", format("%s-nat-%s", var.name, var.azs[count.index])))}"
}

# public route table
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.this.id}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-rtb-public-%s", var.name, var.azs[count.index])))}"
}

# private route table
resource "aws_route_table" "private" {
  count = "${length(var.azs)}"

  vpc_id = "${aws_vpc.this.id}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.this.*.id[count.index]}"
  }

  tags = "${merge(var.tags, map("Name", format("%s-rtb-private-%s", var.name, var.azs[count.index])))}"
}

# route table association
resource "aws_route_table_association" "public" {
  count = "${length(var.public_subnets)}"

  subnet_id      = "${aws_subnet.public_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private_web_subnets" {
  count = "${length(var.private_web_subnets)}"

  subnet_id      = "${aws_subnet.private_web_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

resource "aws_route_table_association" "private_was_subnets" {
  count = "${length(var.private_was_subnets)}"

  subnet_id      = "${aws_subnet.private_was_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

resource "aws_route_table_association" "private_db_subnets" {
  count = "${length(var.private_db_subnets)}"

  subnet_id      = "${aws_subnet.private_db_subnets.*.id[count.index]}"
  route_table_id = "${aws_route_table.private.*.id[count.index]}"
}

resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}"
  acl    = "${var.acl}"

  versioning {
    enabled = "${var.enable_versioning}"
  }

  tags = "${var.tags}"

  #lifecycle = "${var.lifecycle}"
}
