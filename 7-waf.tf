# WAF configuration for Chewbacca REST API Gateway Lab
resource "aws_wafv2_web_acl" "chewbacca_api_waf" {
  name        = "chewbacca-api-waf"
  description = "WAF protection for Chewbacca REST API Gateway Lab"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  # Add AWS Managed Rules for common protections
  rule {
    name     = "AWSManagedRulesCommonRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWSManagedRulesCommonRuleSet"
      sampled_requests_enabled   = true
    }
  }

  # Rate-based rule 100 requests per 5 minutes per IP address
  rule {
    name     = "RateLimitRule"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 100
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "RateLimitRule"
      sampled_requests_enabled   = true
    }
  }

  # Configuration for CloudWatch metrics and sampled requests
  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "chewbacca-api-waf"
    sampled_requests_enabled   = true
  }

  tags = {
    Name        = "chewbacca-api-waf"
    Environment = "Lab"
  }
}

# Associate the WAF with the API Gateway stage
resource "aws_wafv2_web_acl_association" "api_gateway_waf" {
  web_acl_arn  = aws_wafv2_web_acl.chewbacca_api_waf.arn
  resource_arn = aws_api_gateway_stage.prod.arn
}

# Configure WAF logging to CloudWatch Logs
resource "aws_wafv2_web_acl_logging_configuration" "chewbacca_waf_logging" {
  log_destination_configs = ["arn:aws:logs:${var.aws_region}:${data.aws_caller_identity.current.account_id}:log-group:aws-waf-logs-chewbacca-lambda"]
  resource_arn            = aws_wafv2_web_acl.chewbacca_api_waf.arn
}