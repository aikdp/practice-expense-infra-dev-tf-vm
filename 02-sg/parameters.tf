#bastion_sg_id
resource "aws_ssm_parameter" "bastion_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/bastion_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.bastion_sg_id.sg_id
}

#mysql_sg_id
resource "aws_ssm_parameter" "mysql_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/mysql_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.mysql_sg_id.sg_id
}


#backend_sg_id
resource "aws_ssm_parameter" "backend_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/backend_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.backend_sg_id.sg_id
}

#frontend_sg_id
resource "aws_ssm_parameter" "frontend_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/frontend_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.frontend_sg_id.sg_id
}

#app_alb_sg_id
resource "aws_ssm_parameter" "app_alb_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/app_alb_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.app_alb_sg_id.sg_id
}

#web_alb_sg_id
resource "aws_ssm_parameter" "web_alb_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/web_alb_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.web_alb_sg_id.sg_id
}

#vpn_sg_id
resource "aws_ssm_parameter" "vpn_sg_id" {
  name        = "/${var.my_project}/${var.my_env}/vpn_sg_id"
  description = "The parameter description"
  type        = "String"
  value       = module.vpn_sg_id.sg_id
}

