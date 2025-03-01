locals {
  resource_name = "${var.project}-${var.environment}-web-alb"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  web_alb_sg_id = data.aws_ssm_parameter.web_alb_sg_id.value
  acm_https_cert_arn = data.aws_ssm_parameter.acm_https_cert_arn.value
  # app_alb_http_listner_arn = data.aws_ssm_parameter.app_alb_http_listner_arn.value
}