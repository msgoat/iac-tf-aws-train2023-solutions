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

variable "network_name" {
  description = "The name suffix of the VPC."
  type        = string
}

variable "network_cidr" {
  description = "The CIDR range of the VPC."
  type        = string
}

variable "inbound_traffic_cidrs" {
  description = "The IP ranges in CIDR notation allowed to access any public resource within the network."
  type        = list(string)
}

variable "zones_to_span" {
  description = "The number of availability zones the VPC is supposed to span. (default: 0 == all availability zones)"
  type        = number
  default     = 0
}

variable "nat_strategy" {
  description = "NAT strategy to be applied to VPC. Possible values are: NAT_NONE (no NAT gateways), NAT_GATEWAY_SINGLE (one NAT gateway for all AZs in the VPC) or NAT_GATEWAY_AZ (one NAT gateway per AZ)"
  type        = string
}

variable "number_of_bastion_instances" {
  description = "Number of bastion EC2 instances that must be always available; set to 0 if you don't want to have any bastion servers"
  type        = number
}
