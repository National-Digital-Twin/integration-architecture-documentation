locals {
  account_id          = data.aws_caller_identity.current.account_id
  resource_prefix     = "${lower(var.project_name)}-${lower(var.environment)}"
  azs_count           = 3
  azs                 = slice(data.aws_availability_zones.available.names, 0, local.azs_count)
  web_subnet_cidrs    = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 6, k)]        # /22
  app_subnet_cidrs    = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 5, k + 2)]    # /21
  db_subnet_cidrs     = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 6, k + 12)]   # /22
  public_subnet_cidrs = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 8, k + 60)]   # /24
  nwfw_subnet_cidrs   = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 11, k + 504)] # /27
}
