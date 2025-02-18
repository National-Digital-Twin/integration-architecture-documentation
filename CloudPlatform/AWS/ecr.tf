resource "aws_ecr_repository" "ndtp" {
  name                 = local.resource_prefix
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_repository" "repos" {
  for_each             = toset(var.ecr_repo_names)
  name                 = each.key
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_pull_through_cache_rule" "public_ecr" {
  ecr_repository_prefix = "public-ecr"
  upstream_registry_url = "public.ecr.aws"
}

resource "aws_ecr_pull_through_cache_rule" "public_k8s" {
  ecr_repository_prefix = "public-k8s"
  upstream_registry_url = "registry.k8s.io"
}
