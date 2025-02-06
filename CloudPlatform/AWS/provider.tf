terraform {
  backend "s3" {
    bucket = "ndtp-terraform"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.83.0"
    }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "~> 2.35"
    # }
    # helm = {
    #   source  = "hashicorp/helm"
    #   version = "~> 2.17"
    # }
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = var.environment
      Creator     = "Terraform"
    }
  }
}

# provider "kubernetes" {
#   config_path = "~/.kube/config"
# }

# provider "helm" {
#   kubernetes {
#     config_path = "~/.kube/config"
#   }
# }
