
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "module_name" {
  default = "backend"
}


variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "backend"
    Terraform   = "true"
    environment = "dev"
  }
}

variable "my_password"{
  type = string
}

variable "user_name"{
  type = string
}


variable "zone_name"{
  default = "telugudevops.online"
}

