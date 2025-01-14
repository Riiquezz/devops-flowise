output "datadog_integration_aws_status" {
  description = "Status of the AWS integration with Datadog"
  value       = datadog_integration_aws.main.status
}

output "datadog_dashboard_url" {
  description = "URL of the Flowise Observability Dashboard in Datadog"
  value       = "https://app.datadoghq.com/dashboard/${datadog_dashboard.flowise_dashboard.id}"
}

output "datadog_integration_role_arn" {
  description = "IAM Role ARN used for the Datadog AWS integration"
  value       = var.datadog_integration_role
}
