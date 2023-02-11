provider aws {
  region = var.region_name
}

locals {
  module_common_tags = {
    Organization    = var.organization_name
    Department      = var.department_name
    Solution        = var.solution_name
    Stage           = var.solution_stage
    CostCenter      = "1234567890"
    TrainingSession = "2023-02-13"
    ManagedBy       = "Terraform"
  }
}

module backend {
  source = "../../../../../../iac-tf-aws-cloudtrain-modules//modules/terraform/remote-state"
  region_name = var.region_name
  solution_name = var.solution_name
  solution_fqn = var.solution_fqn
  solution_stage = var.solution_stage
  common_tags = local.module_common_tags
  backend_name = "train202302"
}
