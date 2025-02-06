resource "aws_route53_zone" "vpce" {
  count = var.shared_vpce_service_name != null ? 0 : 1
  name  = var.global_service ? local.global_hostedzone : local.hostedzone
  dynamic "vpc" {
    for_each = local.vpc_ids
    content {
      vpc_id = vpc.value
    }
  }
}

resource "aws_route53_record" "vpce" {
  count = var.shared_vpce_service_name != null ? 0 : 1
  name  = aws_route53_zone.vpce[0].name
  type  = var.record_type
  alias {
    name                   = aws_vpc_endpoint.vpce.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.vpce.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }
  zone_id = aws_route53_zone.vpce[0].zone_id
}

resource "aws_route53_record" "vpce_wildcard" {
  count = var.shared_vpce_service_name != null ? 0 : 1
  name  = var.global_service ? local.global_wildcard_record : local.wildcard_record
  type  = var.record_type
  alias {
    name                   = aws_vpc_endpoint.vpce.dns_entry[0].dns_name
    zone_id                = aws_vpc_endpoint.vpce.dns_entry[0].hosted_zone_id
    evaluate_target_health = true
  }
  zone_id = aws_route53_zone.vpce[0].zone_id

  lifecycle {
    ignore_changes = [alias]
  }
}
