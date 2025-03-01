#SSM
data "aws_ssm_parameter" "vpc_id" {
  name = "/${var.my_project}/${var.my_env}/vpc_id"
}

