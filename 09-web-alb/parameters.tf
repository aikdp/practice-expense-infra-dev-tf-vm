

resource "aws_ssm_parameter" "web_alb_target_group" {
  name        = "/${var.project}/${var.environment}/web_alb_target_group"
  description = "The parameter description aws_lb_listener"
  type        = "String"
  value       = aws_lb_target_group.frontend.arn
}
