locals {
  resource_name = "${var.project}-${var.environment}-${var.module_name}"

  ami_id = data.aws_ami.rhel.id

  frontend_sg_id = data.aws_ssm_parameter.frontend_sg_id.value

  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

  vpc_id = data.aws_ssm_parameter.vpc_id.value

  # app_alb_http_listner_arn = data.aws_ssm_parameter.app_alb_http_listner_arn.value
  
  web_alb_target_group = data.aws_ssm_parameter.web_alb_target_group.value
}
