# main.tf
# ----------------------------------------------------------------------------
# Single Terraform file with main entrypoint of this Terraform module.
# ----------------------------------------------------------------------------

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region_name
}

# Local values used in this module
locals {
  main_common_tags = {
    Organization    = var.organization_name
    Department      = var.department_name
    Solution        = var.solution_name
    Stage           = var.solution_stage
    CostCenter      = "1234567890"
    TrainingSession = "2023-02-13"
    ManagedBy       = "Terraform"
  }
}

# retrieve the current AWS availability zones
data "aws_availability_zones" "current" {
  state = "available"
}

# --- VPC section

locals {
  vpc_name = "vpc-${var.region_name}-${var.solution_fqn}-${var.network_name}"
}

# create a VPC
resource "aws_vpc" "vpc" {
  cidr_block           = var.network_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags                 = merge({ Name = local.vpc_name }, local.main_common_tags)
}

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

# --- Internet Gateway section

locals {
  igw_name = "igw-${var.region_name}-${var.solution_fqn}-${var.network_name}"
}

# create an Internet Gateway to provide internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = local.igw_name }, local.main_common_tags)
}
