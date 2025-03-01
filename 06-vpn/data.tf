#SG_id
data "aws_ssm_parameter" "vpn_sg_id"{
    name = "/${var.project}/${var.environment}/vpn_sg_id"
}



data "aws_ssm_parameter" "public_subnet_ids"{
    name = "/${var.project}/${var.environment}/public_subnet_ids"
}
    

#devops-practice
data "aws_ami" "openvpn" {

  most_recent      = true

  owners           = ["679593333241"]

  filter {
    name   = "name"
    values = ["OpenVPN Access Server Community Image-f*"]
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