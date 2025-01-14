output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "datadog_dashboard_url" {
  description = "URL of the Flowise Observability Dashboard in Datadog"
  value       = module.datadog.datadog_dashboard_url
}
