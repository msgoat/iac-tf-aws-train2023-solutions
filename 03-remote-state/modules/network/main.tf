terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Local values used in this module
locals {
  module_common_tags = merge(var.common_tags, { TerraformModuleName = "network" })
}

# retrieve the current AWS availability zones
data "aws_availability_zones" "current" {
  state = "available"
}
