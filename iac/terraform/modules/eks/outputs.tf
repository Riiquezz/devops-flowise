output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint URL"
  value       = module.eks.cluster_endpoint
}

output "node_group_role_arn" {
  description = "IAM role ARN for the node group"
  value       = module.eks.node_groups["default"].iam_role_arn
}
