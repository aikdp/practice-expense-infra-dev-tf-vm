
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "module_name"{
  default = "vpn"
}

variable "common_tags" {
  type = map
    default = {
      Project     = "expense"
      Module      = "openvpn"
      Terraform   = "true"
      environment = "dev"
  }
}

