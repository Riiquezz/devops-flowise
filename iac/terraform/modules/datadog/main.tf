provider "datadog" {
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "datadog_integration_aws" "main" {
  account_id = var.aws_account_id
  role_name  = var.datadog_integration_role
}

resource "datadog_dashboard" "flowise_dashboard" {
  title       = "Flowise Observability Dashboard"
  layout_type = "ordered"

  widget {
    title       = "CPU Utilization"
    definition {
      type   = "timeseries"
      metric = "aws.ecs.service.cpuutilization"
    }
  }

  widget {
    title       = "Memory Utilization"
    definition {
      type   = "timeseries"
      metric = "aws.ecs.service.memoryutilization"
    }
  }
}
