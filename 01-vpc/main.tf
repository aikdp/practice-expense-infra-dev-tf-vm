module "vpc" {
  # source                             = "../../01-vpc-module-tf"
  source                             = "git::https://github.com/aikdp/01-vpc-module-tf.git?ref=main"
  vpc_cidr                           = var.my_cidr
  project                            = var.my_project
  environment                        = var.my_env
  public_cidrs                       = var.my_pub_cidrs
  private_cidrs                      = var.my_prv_cidrs
  database_cidrs                     = var.my_db_cidrs
  peering_connection_required_or_not = var.peering_connection_required
}