
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "app_name"{
    default = "bastion"
}

variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "bastion"
    Terraform   = "true"
    environment = "dev"
  }
}

