# --- Internet Gateway section

locals {
  igw_name = "igw-${var.region_name}-${var.solution_fqn}-${var.network_name}"
}

# create an Internet Gateway to provide internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = local.igw_name }, local.module_common_tags)
}
