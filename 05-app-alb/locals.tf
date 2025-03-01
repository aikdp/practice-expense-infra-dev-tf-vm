locals {
  resource_name = "${var.project}-${var.environment}-${var.component}"
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  app_alb_sg_id = data.aws_ssm_parameter.app_alb_sg_id.value
  # app_alb_http_listner_arn = data.aws_ssm_parameter.app_alb_http_listner_arn.value
}