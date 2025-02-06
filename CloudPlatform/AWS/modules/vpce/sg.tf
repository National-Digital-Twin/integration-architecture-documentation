resource "aws_security_group" "vpce" {
  name        = "vpce-${var.vpce_name}"
  description = "Security Group for ${upper(var.vpce_name)} VPCe"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.resource_prefix}-vpce-${var.vpce_name}"
  }
}

resource "aws_security_group_rule" "vpce_ingress" {
  type              = "ingress"
  from_port         = var.sg_ingress_port
  to_port           = var.sg_ingress_port
  protocol          = "tcp"
  cidr_blocks       = var.sg_allowed_cidrs
  security_group_id = aws_security_group.vpce.id
}

resource "aws_security_group_rule" "vpce_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = var.sg_allowed_cidrs
  security_group_id = aws_security_group.vpce.id
}
