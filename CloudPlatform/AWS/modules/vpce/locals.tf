locals {
  vpc_ids                  = var.vpc_ids
  wildcard_record          = "*.${var.vpce_name}.${data.aws_region.current.name}.amazonaws.com"
  global_wildcard_record   = "*.${local.vpce_name_reversed}.amazonaws.com"
  vpce_service_name        = "com.amazonaws.${data.aws_region.current.name}.${local.vpce_name_reversed}"
  vpce_global_service_name = "com.amazonaws.${var.vpce_name}"
  hostedzone               = "${var.vpce_name}.${data.aws_region.current.name}.amazonaws.com"
  global_hostedzone        = "${local.vpce_name_reversed}.amazonaws.com"
  vpce_name_reversed       = join(".", reverse(split(".", var.vpce_name)))
}
