variable "datadog_api_key" {
  description = "API Key for Datadog"
  type        = string
}

variable "datadog_app_key" {
  description = "App Key for Datadog"
  type        = string
}

variable "aws_account_id" {
  description = "AWS Account ID for Datadog integration"
  type        = string
}

variable "datadog_integration_role" {
  description = "IAM Role for Datadog integration"
  type        = string
}
