resource "aws_cloudwatch_log_group" "msk" {
  name = "${local.resource_prefix}-msk"
}
