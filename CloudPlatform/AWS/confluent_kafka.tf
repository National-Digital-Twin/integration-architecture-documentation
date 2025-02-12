# Deploy Confluent Kafka using Helm
# resource "helm_release" "confluent_kafka" {
# name             = "confluent-kafka"
# repository       = "https://packages.confluent.io/helm"
# chart            = "confluent-for-kubernetes"
# version          = "0.1033.43" # This is for version 2.9.4, this found here https://packages.confluent.io/helm/index.yaml
# namespace        = "confluent"
# create_namespace = true
# 
# Values for Confluent Kafka configuration
# set {
# name  = "image.registry"
# value = "${local.account_id}.dkr.ecr.eu-west-2.amazonaws.com"
# }

# set {
# name  = "image.repository"
# value = aws_ecr_repository.ndtp.name
# }

# set {
# name  = "image.tag"
# value = "confluent_kafka-0.1033.43"
# }
# }
