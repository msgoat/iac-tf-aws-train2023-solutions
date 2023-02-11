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

variable kubernetes_version {
  description = "Kubernetes version"
  type = string
}

variable kubernetes_cluster_name {
  description = "Logical name of the AWS EKS cluster"
  type = string
}

variable kubernetes_api_access_cidrs {
  description = "CIDR blocks defining source API ranges allowed to access the Kubernetes API"
  type = list(string)
  default = []
}

variable node_groups {
  description = "Templates for node groups attached to the AWS EKS cluster, will be replicated for each spanned zone"
  type = list(object({
    name = string # logical name of this nodegroup
    kubernetes_version = string # Kubernetes version of the blue node group; will default to kubernetes_version, if not specified but may differ from kubernetes_version during cluster upgrades
    min_size = number # minimum size of this node group
    max_size = number # maximum size of this node group
    desired_size = number # desired size of this node group; will default to min_size if set to 0
    disk_size = number # size of attached EBS volume in GB
    capacity_type = string # defines the purchasing option for the EC2 instances in all node groups
    instance_types = list(string) # EC2 instance types which should be used for the AWS EKS worker node groups ordered descending by preference
    labels = map(string) # Kubernetes labels to be attached to each worker node
    taints = list(object({
      key = string
      value = string
      effect = string
    })) # Kubernetes taints to be attached to each worker node
  }))
}
