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

variable "common_tags" {
  description = "Map of common tags to be attached to all AWS resources"
  type        = map(string)
}

variable "network_name" {
  description = "The name suffix of the VPC."
  type        = string
}

variable "network_cidr" {
  description = "The CIDR range of the VPC."
  type        = string
}
