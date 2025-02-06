data "aws_route_tables" "app" {
  count  = local.azs_count
  vpc_id = module.vpc.vpc_id

  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-app-${element(local.azs, count.index)}"]
  }
}

data "aws_route_tables" "public_for_each" {
  for_each = toset(local.azs)
  vpc_id   = module.vpc.vpc_id

  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-public-${each.key}"]
  }
}

data "aws_subnet" "public_for_each" {
  for_each = toset(local.azs)

  filter {
    name   = "tag:Name"
    values = ["${local.resource_prefix}-public-${each.key}"]
  }
}
