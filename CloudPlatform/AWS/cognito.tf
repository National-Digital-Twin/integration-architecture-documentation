resource "aws_cognito_user_pool" "ianode" {
  name                     = local.resource_prefix
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]
}

resource "aws_cognito_user_pool_client" "ianode" {
  name                                 = "${local.resource_prefix}-client"
  user_pool_id                         = aws_cognito_user_pool.ianode.id
  allowed_oauth_flows_user_pool_client = true
  callback_urls                        = ["http://localhost:5555/authorize"]
  explicit_auth_flows                  = ["ALLOW_USER_AUTH", "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  allowed_oauth_flows                  = ["code", "implicit"]
  allowed_oauth_scopes                 = ["email", "openid"]
  generate_secret                      = true
  supported_identity_providers         = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "ianode" {
  domain       = local.resource_prefix
  user_pool_id = aws_cognito_user_pool.ianode.id
}

locals {
  pair_groupname_useremail = flatten([
    for group_name, user_emails in var.cognito_access : [
      for user_email in user_emails : {
        group_name = group_name
        user_email = user_email
      }
    ]
  ])
  unique_users = toset(flatten(values(var.cognito_access)))
}

resource "aws_cognito_user" "ianode_users" {
  for_each     = local.unique_users
  user_pool_id = aws_cognito_user_pool.ianode.id
  username     = split("@", each.key)[0]
  attributes = {
    email          = each.key
    email_verified = true
  }
  temporary_password = "Password1."
}

resource "aws_cognito_user_group" "ianode_groups" {
  for_each     = var.cognito_access
  name         = each.key
  user_pool_id = aws_cognito_user_pool.ianode.id
  description  = "Managed by Terraform"
}

resource "aws_cognito_user_in_group" "ianode_group_members" {
  for_each     = { for idx, pair in local.pair_groupname_useremail : idx => pair }
  user_pool_id = aws_cognito_user_pool.ianode.id
  group_name   = each.value.group_name
  username     = split("@", each.value.user_email)[0]
}
