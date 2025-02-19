module "eks_ianode" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name                             = "${local.resource_prefix}-ianode"
  cluster_version                          = var.eks_cluster_version
  enable_cluster_creator_admin_permissions = false

  cluster_security_group_name            = "${local.resource_prefix}-eks_cluster_sec-group"
  cluster_security_group_use_name_prefix = false
  iam_role_name                          = "${local.resource_prefix}-eks_cluster_iam-role"
  iam_role_use_name_prefix               = false
  node_iam_role_name                     = "${local.resource_prefix}-eks_node_iam-role"
  node_iam_role_use_name_prefix          = false
  node_security_group_name               = "${local.resource_prefix}-eks_node_sec-group"
  node_security_group_use_name_prefix    = false

  kms_key_administrators = [for v in var.eks_access["AmazonEKSClusterAdminPolicy"] : "arn:aws:iam::${local.account_id}:user/${v}"]

  cluster_additional_security_group_ids = [aws_security_group.default_web-app.id, aws_security_group.default_app-db.id]

  cluster_compute_config = {
    enabled = true
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    default = {
      desired_size   = 2
      min_size       = 2
      max_size       = 5
      instance_types = ["c6a.large"]
      timeouts = {
        create = "10m"
        update = "10m"
        delete = "10m"
      }
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
}

resource "aws_eks_addon" "ianode_aws-ebs-csi-driver" {
  cluster_name             = module.eks_ianode.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.aws-ebs-csi-driver.arn
}

locals {
  pair_policyname_username = flatten([
    for policy_name, user_names in var.eks_access : [
      for user_name in user_names : {
        policy_name = policy_name
        user_name   = user_name
      }
    ]
  ])
}

resource "aws_eks_access_entry" "eks_access_entry" {
  for_each      = { for idx, pair in local.pair_policyname_username : idx => pair }
  cluster_name  = module.eks_ianode.cluster_name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${each.value.user_name}"
}

resource "aws_eks_access_policy_association" "eks_policy_association" {
  for_each      = { for idx, pair in local.pair_policyname_username : idx => pair }
  cluster_name  = module.eks_ianode.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/${each.value.policy_name}"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/${each.value.user_name}"

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_entry" "github_actions_entry" {
  cluster_name  = module.eks_ianode.cluster_name
  principal_arn = aws_iam_role.github_actions_role.arn
}

resource "aws_eks_access_policy_association" "github_actions_policy_association" {
  cluster_name  = module.eks_ianode.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_iam_role.github_actions_role.arn

  access_scope {
    type = "cluster"
  }
}
