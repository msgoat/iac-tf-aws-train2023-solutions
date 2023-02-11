output "vpc_id" {
  description = "Unique identifier of the VPC"
  value = module.network.vpc_id
}

output "vpc_name" {
  description = "Fully qualified name of the VPC"
  value = module.network.vpc_name
}

output "subnet_ids" {
  description = "List of unique identifiers of all subnets in the VPC"
  value = module.network.subnet_ids
}

output "subnet_names" {
  description = "List of subnet names in the VPC"
  value = module.network.subnet_names
}