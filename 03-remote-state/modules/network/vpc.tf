# --- VPC section

locals {
  vpc_name = "vpc-${var.region_name}-${var.solution_fqn}-${var.network_name}"
}

# create a VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge({ Name = local.vpc_name }, local.module_common_tags)
}
