output "vpc_id" {
  description = "Unique identifier of the VPC"
  value = module.network.vpc_id
}

output "vpc_name" {
  description = "Fully qualified name of the VPC"
  value = module.network.vpc_name
}
