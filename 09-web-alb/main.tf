#Createing App_ALB
module "web_alb" {
  source = "terraform-aws-modules/alb/aws"

  # internal =  true #If true, the LB will be internal. Defaults to false
  enable_deletion_protection = false  #default is false
  
  name    = "${local.resource_name}"
  vpc_id  = local.vpc_id
  subnets = local.public_subnet_id

  create_security_group = false #default is true
  security_groups = [local.web_alb_sg_id]


  tags = {
    Environment = "Development"
    Project     = "Example"
  }
}

#Create LB listner
resource "aws_lb_listener" "http" {
  load_balancer_arn = module.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi I am from WEB Laod Balancer HTTP</h1>"
      status_code  = "200"
    }
  }
}

#Create LB listner
resource "aws_lb_listener" "https" {
  load_balancer_arn = module.web_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = local.acm_https_cert_arn

   default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Hi I am from WEB LaodBalancer HTTPS</h1>"
      status_code  = "200"
    }
  }
}

#.Create Target Group
resource "aws_lb_target_group" "frontend" {
  name     = "${var.project}-${var.environment}-${var.module_name}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.vpc_id
  target_type = "instance"  #default is instance

  health_check{
    healthy_threshold = 2
    unhealthy_threshold  = 2
    interval = 10
    matcher = "200-299"
    path = "/"
    port = 80
    protocol = "HTTP"
    timeout = 5
}
}

#Create Listner Rule
resource "aws_lb_listener_rule" "frontend" {
  listener_arn = aws_lb_listener.https.arn  
  priority     = 100

  action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.frontend.arn
        weight = 80
      }
    }
  }

  condition {
    host_header {
      values = ["${var.project}-${var.environment}.${var.zone_name}"]    #expense-dev.telugudevops.online
    }
  }
}

#Create Records for APP LB 
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "${var.project}-${var.environment}"  # .app-dev.telugudevops.online
      type    = "A"
      alias   = {
        name    = module.web_alb.dns_name
        zone_id = module.web_alb.zone_id  # This belongs ALB internal hosted zone, not ours
      }
      allow_overwrite = true
    },
  ]
}