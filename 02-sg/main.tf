module "bastion_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.bastion_sg
    vpc_id = local.my_vpc_id
}

module "mysql_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.mysql_sg
    vpc_id = local.my_vpc_id
}

module "backend_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.backend_sg
    vpc_id = local.my_vpc_id
}

module "frontend_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.frontend_sg
    vpc_id = local.my_vpc_id
}

module "app_alb_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.app_alb_sg
    vpc_id = local.my_vpc_id
}

module "web_alb_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.web_alb_sg
    vpc_id = local.my_vpc_id
}

module "ansible_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.ansible_sg
    vpc_id = local.my_vpc_id
}


module "vpn_sg_id"{
    # source = "../../01-sg-module-tf"
    source = "git::https://github.com/aikdp/01-sg-module-tf.git?ref=main"
    project = var.my_project
    environment = var.my_env
    sg_name = var.vpn_sg
    vpc_id = local.my_vpc_id
}


#1.mysql_backend
resource "aws_security_group_rule" "mysql_backend" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.backend_sg_id.sg_id
  security_group_id = module.mysql_sg_id.sg_id
}
#2.mysql_bastion
resource "aws_security_group_rule" "mysql_bastion" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg_id.sg_id
  security_group_id = module.mysql_sg_id.sg_id
}


#3.backend_App_Alb
resource "aws_security_group_rule" "backend_app_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id       = module.app_alb_sg_id.sg_id
  security_group_id = module.backend_sg_id.sg_id
}

#4. backend_bastion
resource "aws_security_group_rule" "backend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg_id.sg_id
  security_group_id = module.backend_sg_id.sg_id
}
#5. backend_ansible
resource "aws_security_group_rule" "backend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.ansible_sg_id.sg_id
  security_group_id = module.backend_sg_id.sg_id
}

# 6.app_alb_frontend
resource "aws_security_group_rule" "app_alb_frontend" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.frontend_sg_id.sg_id
  security_group_id = module.app_alb_sg_id.sg_id
}

# 7.app_alb_bastion
resource "aws_security_group_rule" "app_alb_bastion" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg_id.sg_id
  security_group_id = module.app_alb_sg_id.sg_id
}

# 8.frontend_web_alb
resource "aws_security_group_rule" "frontend_web_alb" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.web_alb_sg_id.sg_id
  security_group_id = module.frontend_sg_id.sg_id
}

# 9.frontend_ansible
resource "aws_security_group_rule" "frontend_ansible" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.ansible_sg_id.sg_id
  security_group_id = module.frontend_sg_id.sg_id
}

# 10.frontend_bastion
resource "aws_security_group_rule" "frontend_bastion" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.bastion_sg_id.sg_id
  security_group_id = module.frontend_sg_id.sg_id
}

# 11.web_alb_public
resource "aws_security_group_rule" "web_alb_public" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg_id.sg_id
}

# 12.web_alb_public
resource "aws_security_group_rule" "web_alb_public_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.web_alb_sg_id.sg_id
}
# # 13.web_alb_bastion
# resource "aws_security_group_rule" "web_alb_bastion" {
#   type              = "ingress"
#   from_port         = 80
#   to_port           = 80
#   protocol          = "tcp"
#   source_security_group_id       = module.bastion_sg_id.sg_id
#   security_group_id = module.web_alb_sg_id.sg_id
# }

#14.bastion_public
resource "aws_security_group_rule" "bastion_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastion_sg_id.sg_id
}

#15. ansible_public
resource "aws_security_group_rule" "ansible_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.ansible_sg_id.sg_id
}


#vpn_public--22, 443, 943, 1194



#backend_vpn--8080, 22===

#app_alb_vpn--80===

#VPN_public
#16 vpn_public
resource "aws_security_group_rule" "vpn_public" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg_id.sg_id
}

#17 vpn_public_443
resource "aws_security_group_rule" "vpn_public_443" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg_id.sg_id
}

#18 vpn_public_943
resource "aws_security_group_rule" "vpn_public_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg_id.sg_id
}

#19 vpn_public_943
resource "aws_security_group_rule" "vpn_public_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn_sg_id.sg_id
}

#20 app_alb_vpn
resource "aws_security_group_rule" "app_alb_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg_id.sg_id
  security_group_id = module.app_alb_sg_id.sg_id
}

#21 app_alb_vpn
resource "aws_security_group_rule" "backend_vpn_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg_id.sg_id
  security_group_id = module.backend_sg_id.sg_id
}

#22 app_alb_vpn_22
resource "aws_security_group_rule" "backend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg_id.sg_id
  security_group_id = module.backend_sg_id.sg_id
}

#23 app_alb_vpn_22
resource "aws_security_group_rule" "frontend_vpn" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id       = module.vpn_sg_id.sg_id
  security_group_id = module.frontend_sg_id.sg_id
}