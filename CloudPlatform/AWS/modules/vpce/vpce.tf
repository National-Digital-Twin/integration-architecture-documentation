resource "aws_vpc_endpoint" "vpce" {
  vpc_endpoint_type   = var.vpce_type
  vpc_id              = var.vpc_id
  service_name        = var.shared_vpce_service_name != null ? var.shared_vpce_service_name : var.global_service ? local.vpce_global_service_name : local.vpce_service_name
  policy              = var.use_vpce_custom_policy ? var.vpce_custom_policy : null
  subnet_ids          = var.endpoint_subnets
  private_dns_enabled = var.private_dns_enabled

  security_group_ids = [
    aws_security_group.vpce.id
  ]

  tags = {
    Name = "${var.vpce_name}-vpce-interface"
  }
}
