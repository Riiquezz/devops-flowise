resource "aws_wafv2_web_acl" "main" {
  name        = var.waf_name
  scope       = "REGIONAL" # Use "CLOUDFRONT" for CloudFront WAF
  description = "WAF for protecting the application"

  default_action {
    allow {}
  }

  # Rule 1: Block Bad Bots
  rule {
    name     = "block-bad-bots"
    priority = 1
    action {
      block {}
    }
    statement {
      byte_match_statement {
        search_string = "BadBot"
        field_to_match {
          single_header {
            name = "User-Agent"
          }
        }
        positional_constraint = "CONTAINS"
        text_transformation {
          priority = 0
          type     = "NONE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-bad-bots"
      sampled_requests_enabled   = true
    }
  }

  # Rule 2: Block Specific IPs
  rule {
    name     = "block-specific-ips"
    priority = 2
    action {
      block {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.blocked_ips.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "block-specific-ips"
      sampled_requests_enabled   = true
    }
  }

  # Rule 3: SQL Injection Protection
  rule {
    name     = "sql-injection-protection"
    priority = 3
    action {
      block {}
    }
    statement {
      sqli_match_statement {
        field_to_match {
          all_query_arguments {}
        }
        text_transformation {
          priority = 0
          type     = "URL_DECODE"
        }
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "sql-injection-protection"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.waf_name
    sampled_requests_enabled   = true
  }
}

# Associate the WAF with a resource (e.g., ALB or API Gateway)
resource "aws_wafv2_web_acl_association" "main" {
  resource_arn = var.resource_arn
  web_acl_arn  = aws_wafv2_web_acl.main.arn
}

# IP Set for Blocking Specific IPs
resource "aws_wafv2_ip_set" "blocked_ips" {
  name        = "blocked-ips"
  scope       = "REGIONAL"
  description = "List of blocked IPs"

  ip_address_version = "IPV4"

  addresses = [
    "192.168.0.1/32",
    "203.0.113.0/24"
  ]

  tags = {
    Environment = "Production"
  }
}
