
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "module_name" {
  default = "frontend"
}


variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "frontend"
    Terraform   = "true"
    environment = "dev"
  }
}

variable "password"{
  type = string
}

variable "user"{
  type = string
}


variable "zone_name"{
  default = "telugudevops.online"
}

