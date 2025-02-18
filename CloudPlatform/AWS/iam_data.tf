data "aws_iam_policy_document" "github_actions_trust" {
  statement {
    sid     = "GitHubActionsAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = var.github_allowed_repos
    }

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
  }
}

data "aws_iam_policy_document" "github_actions_perms" {
  statement {
    sid    = "EcrRepoAccess"
    effect = "Allow"
    actions = [
      "ecr:BatchGetImage",
      "ecr:BatchDeleteImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeImageScanFindings",
      "ecr:GetDownloadUrlForLayer",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:StartImageScan",
      "ecr:UploadLayerPart"
    ]
    resources = concat([aws_ecr_repository.ndtp.arn], [for ecr_repo in aws_ecr_repository.repos : ecr_repo.arn])
  }

  statement {
    sid    = "EKSAccess"
    effect = "Allow"
    actions = [
      "eks:Describe*",
      "eks:AccessKubernetesApi",
      "eks:List*"
    ]
    resources = [module.eks_ianode.cluster_arn]
  }

  statement {
    sid    = "EcrTokenAccess"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "S3Access"
    effect = "Allow"
    actions = [
      "s3:Get*",
      "s3:Put*"
    ]
    resources = ["arn:aws:s3:::ia-node-config", "arn:aws:s3:::ia-node-config/*"] #TODO Bucket needs creating in terraform
  }

  statement {
    sid    = "Ec2Access"
    effect = "Allow"
    actions = [
      "ec2:Get*",
      "ec2:Describe*"
    ]
    resources = ["*"]
  }
}

###############################################################################################

data "aws_iam_policy_document" "aws-ebs-csi-driver_trust-policy" {
  statement {
    sid     = "CSIDriverAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(module.eks_ianode.cluster_oidc_issuer_url, "https://")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(module.eks_ianode.cluster_oidc_issuer_url, "https://")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      type        = "Federated"
      identifiers = ["${module.eks_ianode.oidc_provider_arn}"]
    }
  }
}

data "aws_iam_policy_document" "aws-ebs-csi-driver_policy" {
  statement {
    sid    = "Ec2Access"
    effect = "Allow"
    actions = [
      "ec2:CreateVolume",
      "ec2:DeleteVolume",
      "ec2:ModifyVolume",
      "ec2:DetachVolume",
      "ec2:DescribeVolumes",
      "ec2:DescribeVolumesModifications",
      "ec2:DescribeTags",
      "ec2:DescribeSnapshots",
      "ec2:DescribeInstances",
      "ec2:DescribeAvailabilityZones",
      "ec2:CreateSnapshot",
      "ec2:AttachVolume",
      "ec2:CreateTags"
    ]
    resources = ["*"]
  }
}

###############################################################################################

data "aws_iam_policy_document" "ianode-access-role_trust-policy" {
  statement {
    sid     = "ianodeAccessSaAssume"
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(module.eks_ianode.cluster_oidc_issuer_url, "https://")}:sub"
      values   = ["system:serviceaccount:${local.resource_prefix}:ianode-access-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${trimprefix(module.eks_ianode.cluster_oidc_issuer_url, "https://")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      type        = "Federated"
      identifiers = ["${module.eks_ianode.oidc_provider_arn}"]
    }
  }
}

data "aws_iam_policy_document" "ianode-access-role_policy" {
  statement {
    sid    = "SecretsManagerAccess"
    effect = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [aws_secretsmanager_secret.docdb_cluster_root_password.arn]
  }
}

###############################################################################################
data "aws_iam_policy_document" "ianode_role_policy" {
  statement {
    sid    = "S3Access"
    effect = "Allow"

    resources = [
      module.s3_bucket.s3_bucket_arn,
      "${module.s3_bucket.s3_bucket_arn}/ia-data-extractor-dump}/*",
      "arn:aws:s3:::ia-node-config",   #s3 bucket created via clickops TECH DEBT
      "arn:aws:s3:::ia-node-config/*", #s3 bucket created via clickops TECH DEBT
    ]

    actions = ["s3:*"]
  }

  statement {
    sid       = "EcrRepoNdtpAccess"
    effect    = "Allow"
    resources = concat([aws_ecr_repository.ndtp.arn], [for ecr_repo in aws_ecr_repository.repos : ecr_repo.arn])

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
  }

  statement {
    sid       = "EcrTokenAccess"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ecr:GetAuthorizationToken"]
  }

  statement {
    sid       = "CognitoAccess"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "cognito-identity:Get*",
      "cognito-identity:List*",
      "cognito-identity:Describe*",
      "cognito-idp:Confirm*",
      "cognito-idp:Describe*",
      "cognito-idp:GetUser",
      "cognito-idp:GetUser*",
      "cognito-idp:List*",
      "cognito-idp:ResendConfirmationCode",
      "cognito-idp:RespondToAuthChallenge",
      "cognito-idp:AdminSetUserPassword",
      "cognito-idp:AdminDisableUser",
      "cognito-idp:AdminEnableUser",
    ]
  }

  statement {
    sid       = "MSKClusterAccess"
    effect    = "Allow"
    resources = [aws_msk_cluster.ndtp.arn]

    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:AlterCluster",
      "kafka-cluster:DescribeCluster",
      "kafka-cluster:WriteDataIdempotently",
    ]
  }

  statement {
    sid       = "MSKTopicAccess"
    effect    = "Allow"
    resources = ["${replace(aws_msk_cluster.ndtp.arn, "cluster", "topic")}/*"]

    actions = [
      "kafka-cluster:*Topic*",
      "kafka-cluster:WriteData",
      "kafka-cluster:ReadData",
    ]
  }

  statement {
    sid       = "ElasticacheAccess"
    effect    = "Allow"
    resources = [aws_elasticache_serverless_cache.ndtp.arn]

    actions = [
      "elasticache:Connect",
      "elasticache:Describe*",
    ]
  }
}

###############################################################################################

data "aws_iam_policy_document" "bastion_role_policy" {
  statement {
    sid    = "S3Access"
    effect = "Allow"

    resources = [
      module.s3_bucket.s3_bucket_arn,
      "${module.s3_bucket.s3_bucket_arn}/ia-data-extractor-dump}/*",
      "arn:aws:s3:::ia-node-config",   #s3 bucket created via clickops TECH DEBT
      "arn:aws:s3:::ia-node-config/*", #s3 bucket created via clickops TECH DEBT
    ]

    actions = ["s3:*"]
  }

  statement {
    sid       = "MSKClusterAccess"
    effect    = "Allow"
    resources = [aws_msk_cluster.ndtp.arn]

    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:DescribeCluster",
    ]
  }

  statement {
    sid       = "ElasticacheAccess"
    effect    = "Allow"
    resources = [aws_elasticache_serverless_cache.ndtp.arn]

    actions = [
      "elasticache:Connect",
      "elasticache:Describe*",
    ]
  }
}
