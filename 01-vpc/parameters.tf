#vpc id
resource "aws_ssm_parameter" "vpc_id" {
  name        = "/${var.my_project}/${var.my_env}/vpc_id"
  description = "The parameter description"
  type        = "String"
  value       = module.vpc.vpc_id
}

#public_subnet_ids
resource "aws_ssm_parameter" "public_subnet_ids" {
  name        = "/${var.my_project}/${var.my_env}/public_subnet_ids"
  description = "The parameter description"
  type        = "String"
  value       = join(",", module.vpc.public_subnet_ids)
}

# private_subnet_ids
resource "aws_ssm_parameter" "private_subnet_ids" {
  name        = "/${var.my_project}/${var.my_env}/private_subnet_ids"
  description = "The parameter description"
  type        = "String"
  value       = join(",", module.vpc.subnet_ids_private)
}

# database_subnet_ids
resource "aws_ssm_parameter" "database_subnet_ids" {
  name        = "/${var.my_project}/${var.my_env}/database_subnet_ids"
  description = "The parameter description"
  type        = "String"
  value       = join(",", module.vpc.subnet_ids_database)
}