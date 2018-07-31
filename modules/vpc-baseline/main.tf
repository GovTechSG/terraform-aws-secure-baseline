data "aws_availability_zones" "available" {}

resource "aws_default_vpc" "default" {
  tags {
    Name = "Default VPC"
  }
}

resource "aws_default_route_table" "default" {
  default_route_table_id = "${aws_default_vpc.default.default_route_table_id}"

  tags {
    Name = "Default Route Table"
  }
}

resource "aws_default_network_acl" "default" {
  default_network_acl_id = "${aws_default_vpc.default.default_network_acl_id}"

  tags {
    Name = "Default Network ACL"
  }

  lifecycle {
    ignore_changes = ["subnet_ids"]
  }
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_default_vpc.default.id}"

  tags {
    Name = "Default Security Group"
  }
}

resource "aws_flow_log" "default_vpc_flow_logs" {
  log_group_name = "${var.vpc_flow_logs_group_name}"
  iam_role_arn   = "${var.vpc_flow_logs_iam_role_arn}"
  vpc_id         = "${aws_default_vpc.default.id}"
  traffic_type   = "ALL"
}
