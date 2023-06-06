terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
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

# Retrieve input values from previously executed terraform runs
data terraform_remote_state k8s_foundation {
  backend = "s3"
  config = {
    region         = "eu-central-1"
    bucket         = "s3-eu-central-1-cloudtrain-dev-train202302"
    dynamodb_table = "dyn-eu-central-1-cloudtrain-dev-train202302"
    key            = "train2023/uc-k8s/k8s-foundation/tfstate"
  }
}

# Retrieve authentication information from given EKS cluster
data "aws_eks_cluster" "given" {
  name = data.terraform_remote_state.k8s_foundation.outputs.eks_cluster_name
}

data "aws_eks_cluster_auth" "given" {
  name = data.terraform_remote_state.k8s_foundation.outputs.eks_cluster_name
}

# Setup providers with authentication information of given EKS cluster
provider "kubernetes" {
  host                   = data.aws_eks_cluster.given.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.given.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.given.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.given.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.given.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.given.token
  }
}

module aws_auth {
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/container/eks/addon/aws_auth"
  source = "../../../../iac-tf-aws-cloudtrain-modules/modules/container/eks/addon/rbac"
  region_name = var.region_name
  solution_fqn = var.solution_fqn
  solution_name = var.solution_name
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  eks_cluster_name = data.terraform_remote_state.k8s_foundation.outputs.eks_cluster_name
  eks_cluster_admin_role_names = var.eks_cluster_admin_role_names
}

module "metrics_server" {
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/container/eks/addon/metrics-server"
  source = "../../../../iac-tf-aws-cloudtrain-modules/modules/container/eks/addon/metrics-server"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
}

