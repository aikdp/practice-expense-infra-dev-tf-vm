
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}
variable "component" {
  default = "app-alb"
}

variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "app-alp"
    Terraform   = "true"
    environment = "dev"
  }
}

variable "zone_name"{
  default = "telugudevops.online"
}


variable "module_name" {
  default = "backend"
}

variable "app"{
  default = "app"
}
