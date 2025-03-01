#1.Create Instance
#Instance
module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  ami = local.ami_id
  name = local.resource_name

  instance_type          = "t3.micro"
 
  vpc_security_group_ids = [local.frontend_sg_id]

  subnet_id              = local.public_subnet_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

#2.Configure frontend config with ansible-pull
resource "null_resource" "frontend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.frontend.id
  }

    connection {
        type     = "ssh"
        user     = var.user
        password = var.password
        host     = module.frontend.private_ip
    }
    provisioner "file" {
        source      = "${var.module_name}.sh"
        destination = "/tmp/${var.module_name}.sh"
    }
    provisioner "remote-exec" {
        # Bootstrap script called with public_ip of each node in the cluster
        inline = [
        "sudo chmod +x /tmp/${var.module_name}.sh",
        "sudo sh /tmp/${var.module_name}.sh ${var.module_name} ${var.environment}"
        ]
    }
}

#3.Stop the instance
resource "aws_ec2_instance_state" "frontend" {
  instance_id = module.frontend.id
  state       = "stopped"
  
  depends_on = [null_resource.frontend]
}

#4. Take instance from AMI
resource "aws_ami_from_instance" "frontend" {
  name               = local.resource_name
  
  source_instance_id = module.frontend.id

  depends_on = [aws_ec2_instance_state.frontend]
}

#5. Delete Instance
resource "null_resource" "frontend_delete" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.frontend.id
  }
    connection {
        type     = "ssh"
        user     = var.user
        password = var.password
        host     = module.frontend.private_ip
     }
#    provisioner "local-exec" {
#     command = "terraform destroy -target ${module.frontend.id}"
#   }
  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${module.frontend.id}"
  }
  depends_on = [aws_ami_from_instance.frontend]
}

#6. launch template
resource "aws_launch_template" "frontend" {
  name = local.resource_name

  image_id = aws_ami_from_instance.frontend.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"


  update_default_version = true     #every time update version

#   network_interfaces {
#     subnet_id = local.public_subnet_id
#   }

  vpc_security_group_ids = [local.frontend_sg_id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

}

# #7.Create Target Group
# resource "aws_lb_target_group" "frontend" {
#   name     = "${var.project}-${var.environment}"
#   port     = 8080
#   protocol = "HTTP"
#   vpc_id   = local.vpc_id
#   target_type = "instance"  #default is instance

#   health_check{
#     healthy_threshold = 2
#     unhealthy_threshold  = 2
#     interval = 10
#     matcher = "200-299"
#     path = "/health"
#     port = 8080 
#     protocol = "HTTP"
#     timeout = 30
# }
# }


#8. Create AutoSacling group

resource "aws_autoscaling_group" "frontend" {
  name                      = local.resource_name

  max_size                  = 10
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 1

#   force_delete              = true
    
target_group_arns = [local.web_alb_target_group]
 
 vpc_zone_identifier       = [local.public_subnet_id]

  launch_template {
        id      = aws_launch_template.frontend.id
        version = "$Latest"
  }

    instance_refresh {
        strategy = "Rolling"
        preferences {
            min_healthy_percentage = 50
        }
      triggers = ["launch_template"]
    }

  tag {
    key                 = "Name"
    value               = local.resource_name
    propagate_at_launch = true
  }


  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = "Expense"
    propagate_at_launch = false
  }
}

#Create Autosacling Group policy
resource "aws_autoscaling_policy" "frontend" {
  autoscaling_group_name = aws_autoscaling_group.frontend.name
  name                   = local.resource_name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 70.0
  }
}


# #Create Listner Rule
# resource "aws_lb_listener_rule" "frontend" {
#   listener_arn = local.web_alb_http_listner_arn
#   priority     = 99

#   action {
#     type = "forward"
#     forward {
#       target_group {
#         arn    = aws_lb_target_group.frontend.arn
#         weight = 80
#       }
#     }
#   }

#   condition {
#     host_header {
#       values = ["${var.module_name}.web-${var.environment}.${var.zone_name}"]    #frontend.web-dev.telugudevops.online
#     }
#   }
# }
