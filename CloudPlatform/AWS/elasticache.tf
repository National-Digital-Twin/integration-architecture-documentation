resource "aws_elasticache_serverless_cache" "ndtp" {
  name                     = local.resource_prefix
  description              = "${local.resource_prefix} serverless redis cache"
  engine                   = "redis"
  major_engine_version     = "7"
  daily_snapshot_time      = "01:00"
  snapshot_retention_limit = 1
  security_group_ids       = [aws_security_group.elasticache_redis.id]
  subnet_ids               = module.vpc.private_subnets
  cache_usage_limits {
    data_storage {
      maximum = 5
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = 1000
    }
  }
}

resource "aws_ssm_parameter" "aws_elasticache_serverless_cache_ndtp_address" {
  name  = "${local.resource_prefix}-redis-cache-endpoint_address"
  type  = "String"
  value = aws_elasticache_serverless_cache.ndtp.endpoint[0]["address"]
}

resource "aws_ssm_parameter" "aws_elasticache_serverless_cache_ndtp_port" {
  name  = "${local.resource_prefix}-redis-cache-endpoint_port"
  type  = "String"
  value = aws_elasticache_serverless_cache.ndtp.endpoint[0]["port"]
}
