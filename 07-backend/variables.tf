
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

variable "password"{
  type = string
}

variable "user"{
  type = string
}


variable "zone_name"{
  default = "telugudevops.online"
}

