resource "aws_docdb_cluster" "ndtp" {
  cluster_identifier              = "${local.resource_prefix}-cluster"
  engine                          = "docdb"
  availability_zones              = local.azs
  db_subnet_group_name            = aws_docdb_subnet_group.ndtp.name
  db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.ndtp.name
  master_username                 = "root"
  master_password                 = aws_secretsmanager_secret_version.docdb_cluster_root_password.secret_string
  backup_retention_period         = 5
  preferred_backup_window         = "00:00-02:00"
  skip_final_snapshot             = true
  storage_encrypted               = true
  vpc_security_group_ids          = [aws_security_group.docdb.id]
  enabled_cloudwatch_logs_exports = ["audit", "profiler"]
}

resource "aws_docdb_cluster_instance" "ndtp" {
  for_each                    = toset(local.azs)
  availability_zone           = each.key
  identifier                  = "${lower(local.resource_prefix)}-docdb-cluster-instance-${lower(each.key)}"
  cluster_identifier          = aws_docdb_cluster.ndtp.id
  instance_class              = "db.t3.medium"
  apply_immediately           = true
  copy_tags_to_snapshot       = true
  enable_performance_insights = true
}

resource "aws_docdb_cluster_parameter_group" "ndtp" {
  family      = "docdb5.0"
  name        = local.resource_prefix
  description = "${local.resource_prefix} parameter group"

  parameter {
    name  = "tls"
    value = "enabled"
  }
}

resource "aws_docdb_subnet_group" "ndtp" {
  name       = local.resource_prefix
  subnet_ids = module.vpc.database_subnets
}

resource "random_password" "docdb_cluster_root_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "docdb_cluster_root_password" {
  name                    = "${local.resource_prefix}-docdb-cluster-root-password"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "docdb_cluster_root_password" {
  secret_id     = aws_secretsmanager_secret.docdb_cluster_root_password.id
  secret_string = random_password.docdb_cluster_root_password.result
}

resource "aws_ssm_parameter" "docdb_cluster_endpoint" {
  name  = "${local.resource_prefix}-docdb-cluster-endpoint"
  type  = "String"
  value = aws_docdb_cluster.ndtp.endpoint
}

resource "aws_ssm_parameter" "docdb_cluster_port" {
  name  = "${local.resource_prefix}-docdb-cluster-port"
  type  = "String"
  value = aws_docdb_cluster.ndtp.port
}
