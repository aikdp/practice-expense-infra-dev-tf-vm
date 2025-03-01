#Not default, we create db subnet group
resource "aws_db_subnet_group" "database" {
  name       = local.resource_name
  subnet_ids = local.database_subnet_id

  tags = {
    Name = "My DB subnet group"
  }
}

#RDS
module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.resource_name

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t3.micro"
  allocated_storage = 5

  db_name  = "transactions"
  username = "root"
  manage_master_user_password = false 
  password = "ExpenseApp1"
  port     = "3306"

#   iam_database_authentication_enabled = true

  vpc_security_group_ids = [local.mysql_sg_id]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
#   monitoring_interval    = "30"
#   monitoring_role_name   = "MyRDSMonitoringRole"
#   create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
create_db_subnet_group = false

db_subnet_group_name = aws_db_subnet_group.database.id


skip_final_snapshot = true

  # DB parameter roup
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}


#R53 records
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
#   version = "~> 3.0"

  zone_name = var.zone_name

  records = [
    {
      name    = "${var.component}-${var.environment}"   #mysql-dev.telugudevops.online
      type    = "CNAME"
      ttl     = 1
      records = [
       module.db.db_instance_address
      ]
      allow_overwrite = true
    },
  ]
}