resource "aws_security_group" "default_web-app" {
  name        = "${local.resource_prefix}-default_web-app"
  description = "Allows Web and App subnets to talk to each other"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-default_web-app"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_allow_tls" {
  count             = local.azs_count
  security_group_id = aws_security_group.default_web-app.id
  cidr_ipv4         = local.web_subnet_cidrs[count.index]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "app_allow_tls" {
  count             = local.azs_count
  security_group_id = aws_security_group.default_web-app.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_web_access" {
  count             = local.azs_count
  security_group_id = aws_security_group.default_web-app.id
  cidr_ipv4         = local.web_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_app_access" {
  count             = local.azs_count
  security_group_id = aws_security_group.default_web-app.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

############################################################################

resource "aws_security_group" "default_app-db" {
  name        = "${local.resource_prefix}-default_app-db"
  description = "Allows App and DB subnets to talk to each other"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-default_app-db"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_db_access" {
  count             = local.azs_count
  security_group_id = aws_security_group.default_app-db.id
  cidr_ipv4         = local.db_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

############################################################################

resource "aws_security_group" "ec2_bastion" {
  name        = "${local.resource_prefix}-ec2_bastion"
  description = "EC2 Bastion security group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-ec2_bastion"
  }
}

resource "aws_vpc_security_group_egress_rule" "ec2_bastion_allow_app_access" {
  count             = local.azs_count
  security_group_id = aws_security_group.ec2_bastion.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "ec2_bastion_allow_docdb_access" {
  security_group_id            = aws_security_group.ec2_bastion.id
  referenced_security_group_id = aws_security_group.docdb.id
  from_port                    = aws_docdb_cluster.ndtp.port
  ip_protocol                  = "tcp"
  to_port                      = aws_docdb_cluster.ndtp.port
}

resource "aws_vpc_security_group_egress_rule" "ec2_bastion_allow_internet" {
  security_group_id = aws_security_group.ec2_bastion.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

############################################################################

resource "aws_security_group" "ec2_ianode" {
  name        = "${local.resource_prefix}-ec2_ianode"
  description = "EC2 IAnode security group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-ec2_ianode"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ianode_8091_from_ec2_bastion" {
  security_group_id            = aws_security_group.ec2_ianode.id
  referenced_security_group_id = aws_security_group.ec2_bastion.id
  description                  = "telicent access"
  from_port                    = 8091
  ip_protocol                  = "tcp"
  to_port                      = 8091
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ianode_3030_from_ec2_bastion" {
  security_group_id            = aws_security_group.ec2_ianode.id
  referenced_security_group_id = aws_security_group.ec2_bastion.id
  description                  = "smart cache graph"
  from_port                    = 3030
  ip_protocol                  = "tcp"
  to_port                      = 3030
}

resource "aws_vpc_security_group_ingress_rule" "ec2_ianode_8000_from_ec2_bastion" {
  security_group_id            = aws_security_group.ec2_ianode.id
  referenced_security_group_id = aws_security_group.ec2_bastion.id
  description                  = "federator"
  from_port                    = 8000
  ip_protocol                  = "tcp"
  to_port                      = 8000
}

resource "aws_vpc_security_group_egress_rule" "ec2_ianode_allow_app_access" {
  count             = local.azs_count
  security_group_id = aws_security_group.ec2_ianode.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "ec2_ianode_allow_docdb_access" {
  security_group_id            = aws_security_group.ec2_ianode.id
  referenced_security_group_id = aws_security_group.docdb.id
  from_port                    = aws_docdb_cluster.ndtp.port
  ip_protocol                  = "tcp"
  to_port                      = aws_docdb_cluster.ndtp.port
}

resource "aws_vpc_security_group_egress_rule" "ec2_ianode_allow_s3_access" {
  security_group_id = aws_security_group.ec2_ianode.id
  prefix_list_id    = aws_vpc_endpoint.s3.prefix_list_id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "ec2_ianode_allow_internet" {
  security_group_id = aws_security_group.ec2_ianode.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

############################################################################

resource "aws_security_group" "elasticache_redis" {
  name        = "${local.resource_prefix}-elasticache_redis"
  description = "Elasticache_redis security group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-elasticache_redis"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_elasticache_redis_access_from_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.elasticache_redis.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  from_port         = aws_elasticache_serverless_cache.ndtp.endpoint[0]["port"]
  ip_protocol       = "tcp"
  to_port           = aws_elasticache_serverless_cache.ndtp.endpoint[0]["port"]
}

resource "aws_vpc_security_group_egress_rule" "allow_elasticache_redis_access_to_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.elasticache_redis.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

############################################################################

resource "aws_security_group" "msk" {
  name        = "${local.resource_prefix}-msk"
  description = "MSK security group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-msk"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_msk_access_from_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.msk.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  from_port         = 9098
  ip_protocol       = "tcp"
  to_port           = 9098
}

resource "aws_vpc_security_group_ingress_rule" "allow_msk_zookeeper_access_from_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.msk.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  from_port         = 2182
  ip_protocol       = "tcp"
  to_port           = 2182
}

resource "aws_vpc_security_group_ingress_rule" "allow_msk_access_from_self" {
  security_group_id            = aws_security_group.msk.id
  referenced_security_group_id = aws_security_group.msk.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_msk_access_to_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.msk.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_msk_access_from_self" {
  security_group_id            = aws_security_group.msk.id
  referenced_security_group_id = aws_security_group.msk.id
  ip_protocol                  = "-1"
}

############################################################################

resource "aws_security_group" "docdb" {
  name        = "${local.resource_prefix}-docdb"
  description = "DocDB security group"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name = "${local.resource_prefix}-docdb"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_docdb_access_from_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.docdb.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  from_port         = aws_docdb_cluster.ndtp.port
  ip_protocol       = "tcp"
  to_port           = aws_docdb_cluster.ndtp.port
}

resource "aws_vpc_security_group_ingress_rule" "allow_docdb_access_from_db" {
  count             = local.azs_count
  security_group_id = aws_security_group.docdb.id
  cidr_ipv4         = local.db_subnet_cidrs[count.index]
  from_port         = aws_docdb_cluster.ndtp.port
  ip_protocol       = "tcp"
  to_port           = aws_docdb_cluster.ndtp.port
}

resource "aws_vpc_security_group_egress_rule" "allow_docdb_access_to_app" {
  count             = local.azs_count
  security_group_id = aws_security_group.docdb.id
  cidr_ipv4         = local.app_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_docdb_access_to_db" {
  count             = local.azs_count
  security_group_id = aws_security_group.docdb.id
  cidr_ipv4         = local.db_subnet_cidrs[count.index]
  ip_protocol       = "-1"
}
