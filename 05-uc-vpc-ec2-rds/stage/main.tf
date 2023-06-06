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
  source = "../../../iac-tf-aws-cloudtrain-modules/modules/network/vpc-blueprint"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  network_name = var.network_name
  network_cidr = var.network_cidr
  inbound_traffic_cidrs = var.inbound_traffic_cidrs
  nat_strategy = var.nat_strategy
  number_of_bastion_instances = var.number_of_bastion_instances
}

# to keep things simple retrieve the latest AMI version used for all EC2 instances
data "aws_ami" "amazon_linux2" {
  owners = [
    "137112412989"]
  #  executable_users = ["self"]
  most_recent = "true"
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-*"]
  }
  filter {
    name = "root-device-type"
    values = [
      "ebs"]
  }
  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }
  filter {
    name = "architecture"
    values = [
      "arm64"]
  }
}

module "web_server" {
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/compute/ec2-single"
  source = "../../../iac-tf-aws-cloudtrain-modules/modules/compute/ec2-single"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  instance_name = "train202302-web"
  instance_type = "t4g.micro"
  ami_id = data.aws_ami.amazon_linux2.id
  root_volume_size = 32
  data_volume_size = 128
  instance_key_name = "key-eu-central-1-cloudtrain-dev-train2023"
  vpc_id = module.network.vpc_id
  subnet_id = module.network.web_subnet_ids[0]
}

module "app_server" {
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/compute/ec2-single"
  source = "../../../iac-tf-aws-cloudtrain-modules/modules/compute/ec2-single"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  instance_name = "train202302-app"
  instance_type = "t4g.micro"
  ami_id = data.aws_ami.amazon_linux2.id
  root_volume_size = 32
  data_volume_size = 128
  instance_key_name = "key-eu-central-1-cloudtrain-dev-train2023"
  vpc_id = module.network.vpc_id
  subnet_id = module.network.app_subnet_ids[0]
}

module "postgres" {
  #  source = "git::https://github.com/msgoat/iac-tf-aws-cloudtrain-modules.git//modules/database/postgresql/rds"
  source = "../../../iac-tf-aws-cloudtrain-modules/modules/database/postgresql/rds"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.main_common_tags
  db_instance_name = "train202302"
  db_database_name = "cloudtrain"
  vpc_id = module.network.vpc_id
  db_subnet_ids = module.network.data_subnet_ids
}