variable "waf_name" {
  description = "Name of the WAF ACL"
  type        = string
}

variable "resource_arn" {
  description = "ARN of the resource to attach the WAF (e.g., ALB or API Gateway)"
  type        = string
}
