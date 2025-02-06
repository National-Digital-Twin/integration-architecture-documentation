region       = "eu-west-2"
environment  = "Testing"
project_name = "ndtp"

## IAM
github_allowed_repos = ["repo:National-Digital-Twin/*"]

## VPC
vpc_cidr = "10.0.0.0/16"

## EKS
eks_cluster_version = "1.31"
eks_access = {
  AmazonEKSClusterAdminPolicy = [
    "kyle.southworth",
    "nick.moynihan",
    "eugene.fahy",
    "martin.willitts"
  ],
  AmazonEKSEditPolicy = [
    "harrison.duffield",
    "lewis.birks",
    "ajith.thomas",
    "apurva.jhunjhunwala",
    "radoslaw.przybysz",
    "vijay.babu"
  ]
}

## Cognito
cognito_access = {
  # The below creates a group, the users and the adds the users into the group they are under
  #<cognito_group_name> = [
  #   "<cognito_group_member_user_email>"
  #]
  ianode_read = [
    "user_1.test@ndtp.net",
    "user_3.test@ndtp.net"
  ]
  ianode_admin = [
    "user_1.test@ndtp.net",
    "user_2.test@ndtp.net"
  ]
  tc_read = [ # To be removed after refactoring of smart-cache-graph is completed
    "user_1.test@ndtp.net",
    "user_3.test@ndtp.net"
  ]
  tc_admin = [ # To be removed after refactoring of smart-cache-graph is completed
    "user_1.test@ndtp.net",
    "user_2.test@ndtp.net"
  ]
}
