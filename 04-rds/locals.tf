locals {
  resource_name = "${var.project}-${var.environment}"
  mysql_sg_id = data.aws_ssm_parameter.mysql_sg_id.value
  database_subnet_id = split(",", data.aws_ssm_parameter.database_subnet_ids.value)
}