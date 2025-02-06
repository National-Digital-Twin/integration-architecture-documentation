resource "aws_iam_openid_connect_provider" "github_idp" {
  url = var.github_idp_url
  client_id_list = [
    var.github_idp_audience
  ]
  thumbprint_list = var.github_idp_thumbprints
}

resource "aws_iam_role" "github_actions_role" {
  name                  = "github_actions_role"
  description           = "Role used by Github Actions"
  assume_role_policy    = data.aws_iam_policy_document.github_actions_trust.json
  force_detach_policies = true
}

resource "aws_iam_policy" "github_actions_role_ecr_perms" {
  name   = "github_actions_role_ecr_perms"
  policy = data.aws_iam_policy_document.github_actions_ecr_perms.json
}

resource "aws_iam_role_policy_attachment" "github_actions_role_ssm_perms" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy_attachment" "github_actions_role_ecr_perms" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_role_ecr_perms.arn
}

resource "aws_iam_role" "aws-ebs-csi-driver" {
  name               = "${local.resource_prefix}-aws-ebs-csi-driver-role"
  description        = "AWS IAM Role for the aws-ebs-csi-driver Kubernetes service account."
  assume_role_policy = data.aws_iam_policy_document.aws-ebs-csi-driver_trust-policy.json
}

resource "aws_iam_policy" "aws-ebs-csi-driver" {
  name   = "${local.resource_prefix}-aws-ebs-csi-driver_policy"
  policy = data.aws_iam_policy_document.aws-ebs-csi-driver_policy.json
}

resource "aws_iam_role_policy_attachment" "aws-ebs-csi-driver" {
  policy_arn = aws_iam_policy.aws-ebs-csi-driver.arn
  role       = aws_iam_role.aws-ebs-csi-driver.name
}

resource "aws_iam_policy" "ianode_role" {
  name   = "${local.resource_prefix}-ianode_ec2_role_policy"
  policy = data.aws_iam_policy_document.ianode_role_policy.json
}

resource "aws_iam_policy" "bastion_role" {
  name   = "${local.resource_prefix}-bastion_ec2_role_policy"
  policy = data.aws_iam_policy_document.bastion_role_policy.json
}
