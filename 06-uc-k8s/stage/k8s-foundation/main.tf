terraform {
  backend "s3" {
  }
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
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/network/vpc-blueprint"
  source = "../../../../iac-tf-aws-cloudtrain-modules/modules/network/vpc-blueprint"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  network_name = var.network_name
  network_cidr = var.network_cidr
  inbound_traffic_cidrs = var.inbound_traffic_cidrs
  nat_strategy = var.nat_strategy
  number_of_bastion_instances = 0
  zones_to_span = var.zones_to_span
}

module "eks_cluster" {
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/container/eks/cluster"
  source = "../../../../iac-tf-aws-cloudtrain-modules/modules/container/eks/cluster"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  kubernetes_cluster_name = var.kubernetes_cluster_name
  kubernetes_version = var.kubernetes_version
  kubernetes_api_access_cidrs = length(var.kubernetes_api_access_cidrs) == 0 ? var.inbound_traffic_cidrs : var.kubernetes_api_access_cidrs
  node_group_subnet_ids = module.network.app_subnet_ids
  node_group_templates = var.node_group_templates
  vpc_id = module.network.vpc_id
  zones_to_span = var.zones_to_span
}
