

# resource "aws_ssm_parameter" "app_alb_http_listner_arn" {
#   name        = "/${var.project}/${var.environment}/app_alb_http_listner_arn"
#   description = "The parameter description aws_lb_listener"
#   type        = "String"
#   value       = aws_lb_listener.http.arn
# }


resource "aws_ssm_parameter" "app_alb_target_group" {
  name        = "/${var.project}/${var.environment}/app_alb_target_group"
  description = "The parameter description aws_lb_listener"
  type        = "String"
  value       = aws_lb_target_group.backend.arn
}
