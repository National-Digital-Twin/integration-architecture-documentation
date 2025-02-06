module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = local.resource_prefix
  cidr = var.vpc_cidr

  azs = local.azs

  enable_nat_gateway                  = true
  create_multiple_public_route_tables = true

  create_igw                       = false
  create_private_nat_gateway_route = false
  create_egress_only_igw           = false
  create_database_subnet_group     = false
  create_elasticache_subnet_group  = false
  create_redshift_subnet_group     = false
  manage_default_network_acl       = false
  manage_default_route_table       = false
  manage_default_security_group    = false

  public_subnets        = local.public_subnet_cidrs
  private_subnets       = local.app_subnet_cidrs
  private_subnet_suffix = "app"
  database_subnets      = local.db_subnet_cidrs
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-igw"
  }
}

resource "aws_subnet" "web" {
  count             = local.azs_count
  vpc_id            = module.vpc.vpc_id
  availability_zone = element(concat(local.azs, [""]), count.index)
  cidr_block        = element(concat(local.web_subnet_cidrs, [""]), count.index)
  tags = {
    Name = "${local.resource_prefix}-web-${element(local.azs, count.index)}"
  }
}

resource "aws_route_table_association" "web" {
  count          = local.azs_count
  subnet_id      = element(aws_subnet.web[*].id, count.index)
  route_table_id = element(data.aws_route_tables.app[count.index].ids, count.index)
}

resource "aws_subnet" "nwfw" {
  count             = local.azs_count
  vpc_id            = module.vpc.vpc_id
  availability_zone = element(concat(local.azs, [""]), count.index)
  cidr_block        = element(concat(local.nwfw_subnet_cidrs, [""]), count.index)
  tags = {
    Name = "${local.resource_prefix}-nwfw-${element(local.azs, count.index)}"
  }
}

resource "aws_route_table" "igw" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "${local.resource_prefix}-igw"
  }
}

resource "aws_route_table_association" "igw" {
  gateway_id     = aws_internet_gateway.igw.id
  route_table_id = aws_route_table.igw.id
}

resource "aws_route" "rt_igw_public" {
  for_each               = toset(local.azs)
  route_table_id         = aws_route_table.igw.id
  destination_cidr_block = data.aws_subnet.public_for_each[each.key].cidr_block
  vpc_endpoint_id        = data.aws_vpc_endpoint.nwfw[each.key].id
}

resource "aws_route_table" "nwfw" {
  count  = local.azs_count
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "${local.resource_prefix}-nwfw-${element(local.azs, count.index)}"
  }
}

resource "aws_route_table_association" "nwfw" {
  count          = local.azs_count
  subnet_id      = element(aws_subnet.nwfw[*].id, count.index)
  route_table_id = aws_route_table.nwfw[count.index].id
}

resource "aws_route" "rt_nwfw_igw" {
  count                  = local.azs_count
  route_table_id         = aws_route_table.nwfw[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "rt_public_nwfw" {
  for_each               = toset(local.azs)
  route_table_id         = data.aws_route_tables.public_for_each[each.key].ids[0]
  destination_cidr_block = "0.0.0.0/0"
  vpc_endpoint_id        = data.aws_vpc_endpoint.nwfw[each.key].id
}

resource "aws_route" "rt_app_nwfw" {
  count                  = local.azs_count
  route_table_id         = element(data.aws_route_tables.app[count.index].ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = module.vpc.natgw_ids[count.index]
}

module "vpce" {
  source           = "./modules/vpce"
  for_each         = toset(var.vpc_endpoints)
  vpce_name        = each.value
  vpc_id           = module.vpc.vpc_id
  vpc_ids          = [module.vpc.vpc_id]
  sg_allowed_cidrs = [var.vpc_cidr]
  endpoint_subnets = module.vpc.private_subnets
  resource_prefix  = local.resource_prefix
}

resource "aws_vpc_endpoint" "s3" {
  service_name    = "com.amazonaws.${var.region}.s3"
  vpc_id          = module.vpc.vpc_id
  route_table_ids = module.vpc.private_route_table_ids

  tags = {
    Name = "s3-vpce-gateway"
  }
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  count           = local.azs_count
  route_table_id  = element(data.aws_route_tables.app[count.index].ids, count.index)
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}
