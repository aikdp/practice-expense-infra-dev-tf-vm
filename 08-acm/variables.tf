
variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "common_tags" {
  type = map
  default = {
    Project     = "expense"
    Module      = "ACM"
    Terraform   = "true"
    environment = "dev"
  }
}



variable "zone_name"{
  default = "telugudevops.online"
}

# variable "hosted_zone_id"{
#   default = "Z0873413X28XY5FKMLIP"
# }