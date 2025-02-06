resource "aws_wafv2_ip_set" "nat_gw" {
  name               = "${local.resource_prefix}-nat_gw_ips"
  description        = "${local.resource_prefix} VPC NAT gateways"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = formatlist("%s/32", module.vpc.nat_public_ips)
}

resource "aws_wafv2_web_acl" "cognito" {
  name        = "${local.resource_prefix}-cognito"
  description = "${local.resource_prefix} Cognito web acl"
  scope       = "REGIONAL"
  default_action {
    block {}
  }
  rule {
    name     = "Allow_NAT_gw_IPs"
    priority = 1
    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.nat_gw.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "${local.resource_prefix}-cognito-web_acl"
      sampled_requests_enabled   = false
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "${local.resource_prefix}-cognito-web_acl"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "cognito" {
  resource_arn = aws_cognito_user_pool.ianode.arn
  web_acl_arn  = aws_wafv2_web_acl.cognito.arn
}
