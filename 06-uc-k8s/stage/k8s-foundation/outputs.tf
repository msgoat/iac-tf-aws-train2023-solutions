output "vpc_id" {
  description = "Unique identifier of the VPC"
  value = module.network.vpc_id
}

output "vpc_name" {
  description = "Fully qualified name of the VPC"
  value = module.network.vpc_name
}

output "eks_cluster_id" {
  description = "Unique identifier of the EKS cluster"
  value = module.eks_cluster.eks_cluster_arn
}

output "eks_cluster_name" {
  description = "Fully qualified name of the EKS cluster"
  value = module.eks_cluster.eks_cluster_name
}
