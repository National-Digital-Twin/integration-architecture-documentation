data "aws_vpc_endpoint" "nwfw" {
  for_each = toset(local.azs)

  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix} (${each.key})"]
  }

  filter {
    name   = "tag:Firewall"
    values = [module.network_firewall.arn]
  }
}
