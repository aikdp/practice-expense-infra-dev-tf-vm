
variable "my_project" {
  default = "expense"
}

variable "my_env" {
  default = "dev"
}

variable "bastion_sg"{
    default = "bastion"
}

variable "mysql_sg"{
    default = "mysql"
}

variable "backend_sg"{
    default = "backend"
}

variable "frontend_sg"{
    default = "frontend"
}

variable "ansible_sg"{
  default = "ansible"
}

variable "app_alb_sg"{
  default = "app-alb"
}

variable "web_alb_sg"{
  default = "web-alb"
}
variable "vpn_sg"{
  default = "opnvpn"
}

# variable "ansible_sg" {
#   default = "ansible"
# }


variable "common_tags" {
  type = map(any)
  default = {
    Project     = "expense"
    Module      = "sg"
    Terraform   = "true"
    environment = "dev"
  }
}

