locals {
  resource_name = "${var.project}-${var.environment}-${var.module_name}"
  ami_id = data.aws_ami.openvpn.id
  vpn_sg_id = data.aws_ssm_parameter.vpn_sg_id.value
  public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

}