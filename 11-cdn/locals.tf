locals {
  resource_name = "${var.project}-${var.environment}-${var.module_name}"
  acm_https_cert_arn = data.aws_ssm_parameter.acm_https_cert_arn.value
}
