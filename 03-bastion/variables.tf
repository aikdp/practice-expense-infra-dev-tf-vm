
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

variable "user_name"{

}

variable "my_password"{

}

# export TF_VAR_my_password="<PASSWORD>"
# export TF_VAR_user_name="<USER_NAME>"