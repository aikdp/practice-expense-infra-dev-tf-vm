# output "zones_info"{
#     value = module.vpc.avail_zones_info
# }

output "vpc_mine" {
  value = module.vpc.vpc_id
}

# output "vpc_default"{
#     value = module.vpc.default_vpc
# }
# output "rtb_default"{
#     value = module.vpc.default_rtb
# }

output "pub_sub_ids"{
    value = module.vpc.public_subnet_ids
}

output "prv_sub_ids"{
    value = module.vpc.subnet_ids_private
}

output "db_sub_ids"{
    value = module.vpc.subnet_ids_database
}
