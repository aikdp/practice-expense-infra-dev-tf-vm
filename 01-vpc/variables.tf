variable "my_cidr" {
  default = "10.0.0.0/16"
}
variable "my_project" {
  default = "expense"

}

variable "my_env" {
  default = "dev"
}

variable "common_tags" {
  type = map(any)
  default = {
    Project     = "expense"
    Module      = "vpc"
    Terraform   = "true"
    environment = "dev"
  }
}

variable "my_pub_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "my_prv_cidrs" {
  default = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "my_db_cidrs" {
  default = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "peering_connection_required" {
  type    = bool
  default = true
}