locals {
  resource_name = "${var.project}-${var.environment}-backend"
  ami_id = data.aws_ami.rhel.id
  backend_sg_id = data.aws_ssm_parameter.backend_sg_id.value
  private_subnet_id = split(",", data.aws_ssm_parameter.private_subnet_ids.value)[0]
  vpc_id = data.aws_ssm_parameter.vpc_id.value
  # app_alb_http_listner_arn = data.aws_ssm_parameter.app_alb_http_listner_arn.value
  app_alb_target_group = data.aws_ssm_parameter.app_alb_target_group.value
}