variable "vpc_cidr" {
  type        = string
  description = "CIDR used for the VPC"
}

variable "vpc_endpoints" {
  type        = list(string)
  description = "VPC endpoint names"
  default     = ["autoscaling", "api.ecr", "dkr.ecr", "ssm", "ssmmessages", "ec2", "ec2messages", "logs", "s3", "elasticloadbalancing", "sts", "kms"]
}
