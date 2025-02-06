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
