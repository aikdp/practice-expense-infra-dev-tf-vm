
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}
variable "component" {
  default = "web-alb"
}

variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "web-alp"
    Terraform   = "true"
    environment = "dev"
  }
}

variable "zone_name"{
  default = "telugudevops.online"
}


variable "module_name" {
  default = "frontend"
}

