
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}
variable "component" {
  default = "mysql"
}

variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "app"
    Terraform   = "true"
    environment = "dev"
  }
}

variable "zone_name"{
  default = "telugudevops.online"
}

variable "db_password"{
  type = string
}
