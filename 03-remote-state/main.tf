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

module "network" {
  source = "./modules/network"
  region_name = var.region_name
  organization_name = var.organization_name
  department_name = var.department_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  network_name = var.network_name
  network_cidr = var.network_cidr
}