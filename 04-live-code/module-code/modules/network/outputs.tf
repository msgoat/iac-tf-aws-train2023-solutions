output "vpc_id" {
  description = "Unique identifier of the VPC"
  value = aws_vpc.vpc.id
}

output "vpc_name" {
  description = "Fully qualified name of the VPC"
  value = aws_vpc.vpc.tags["Name"]
}

output "subnet_ids" {
  description = "List of unique identifiers of all subnets in the VPC"
  value = aws_subnet.public_subnets.*.id
}

output "subnet_names" {
  description = "List of subnet names in the VPC"
  value = [for subnet in aws_subnet.public_subnets : subnet.tags["Name"]]
}