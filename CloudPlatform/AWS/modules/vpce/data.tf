data "aws_region" "current" {}

data "aws_network_interface" "vpce_network_interfaces" {
  count = var.vpce_type == "Interface" ? length(var.endpoint_subnets) : 0
  id    = tolist(aws_vpc_endpoint.vpce.network_interface_ids)[count.index]
}
