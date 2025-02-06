resource "aws_msk_cluster" "ndtp" {
  cluster_name           = local.resource_prefix
  kafka_version          = "3.7.x"
  number_of_broker_nodes = local.azs_count

  broker_node_group_info {
    instance_type   = "kafka.t3.small"
    client_subnets  = module.vpc.private_subnets
    security_groups = [aws_security_group.msk.id]

    storage_info {
      ebs_storage_info {
        volume_size = 100
        provisioned_throughput {
          enabled = false
        }
      }
    }
  }

  configuration_info {
    arn      = aws_msk_configuration.ndtp.arn
    revision = aws_msk_configuration.ndtp.latest_revision
  }

  client_authentication {
    unauthenticated = false
    sasl {
      iam = true
    }
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
      node_exporter {
        enabled_in_broker = true
      }
    }
  }

  logging_info {
    broker_logs {
      cloudwatch_logs {
        enabled   = true
        log_group = aws_cloudwatch_log_group.msk.name
      }
    }
  }
}

resource "aws_msk_configuration" "ndtp" {
  kafka_versions    = ["3.7.x"]
  name              = local.resource_prefix
  server_properties = <<PROPERTIES
auto.create.topics.enable = true
zookeeper.connection.timeout.ms = 6000
delete.topic.enable = true
num.partitions = 1
log.retention.hours = 72
PROPERTIES
}

resource "aws_ssm_parameter" "aws_msk_cluster_ndtp_broker_addresses" {
  name  = "${local.resource_prefix}-msk-cluster-broker-addresses"
  type  = "String"
  value = aws_msk_cluster.ndtp.bootstrap_brokers_sasl_iam
}
