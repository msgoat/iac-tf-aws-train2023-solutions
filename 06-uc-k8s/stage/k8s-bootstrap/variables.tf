variable "region_name" {
  description = "The AWS region to deploy into (e.g. eu-central-1)."
  type        = string
}

variable "organization_name" {
  description = "The name of the organization that owns all AWS resources."
  type        = string
}

variable "department_name" {
  description = "The name of the department that owns all AWS resources."
  type        = string
}

variable "solution_name" {
  description = "The name of the project that owns all AWS resources."
  type        = string
}

variable "solution_stage" {
  description = "The name of the current solutions stage."
  type        = string
}

variable "solution_fqn" {
  description = "The fully qualified name of the project that owns all AWS resources."
  type        = string
}
