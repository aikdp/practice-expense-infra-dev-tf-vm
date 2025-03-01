#SG_id
data "aws_ssm_parameter" "backend_sg_id"{
    name = "/${var.project}/${var.environment}/backend_sg_id"
}


data "aws_ssm_parameter" "private_subnet_ids"{
    name = "/${var.project}/${var.environment}/private_subnet_ids"
}
    


#devops-practice
data "aws_ami" "rhel" {

  most_recent      = true

  owners           = ["973714476881"]

  filter {
    name   = "name"
    values = ["RHEL-9-DevOps-Practice"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ssm_parameter" "vpc_id"{
    name = "/${var.project}/${var.environment}/vpc_id"
}


# data "aws_ssm_parameter" "lb_listener_http"{
#     name = "/${var.project}/${var.environment}/lb_listener_http"
# }

data "aws_ssm_parameter" "app_alb_target_group"{
    name = "/${var.project}/${var.environment}/app_alb_target_group"
}

