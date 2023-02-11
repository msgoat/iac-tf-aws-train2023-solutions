# --- Subnet section

locals {
  subnet_names       = [for zone_name in data.aws_availability_zones.current.names : "sn-${zone_name}-${var.solution_fqn}-${var.network_name}-public"]
  subnet_cidr_blocks = cidrsubnets(var.network_cidr, 8, 8, 8)
}

# create a public subnet in each Availability Zone
resource "aws_subnet" "public_subnets" {
  count             = length(local.subnet_names)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.subnet_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.current.names[count.index]
  tags              = merge({ Name = local.subnet_names[count.index] }, local.main_common_tags)
}
