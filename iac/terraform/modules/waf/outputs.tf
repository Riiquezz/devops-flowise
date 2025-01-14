output "waf_id" {
  description = "ID of the WAF"
  value       = aws_wafv2_web_acl.main.id
}

output "waf_arn" {
  description = "ARN of the WAF"
  value       = aws_wafv2_web_acl.main.arn
}
