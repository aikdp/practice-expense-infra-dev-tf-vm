
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "module_name" {
  default = "cdn"
}


variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "cdn"
    Terraform   = "true"
    environment = "dev"
  }
}


variable "zone_name"{
  default = "telugudevops.online"
}

