
resource "aws_ssm_parameter" "acm_https_cert_arn" {
  name        = "/${var.project}/${var.environment}/acm_https_cert_arn"
  description = "The parameter description aws_lb_listener"
  type        = "String"
  value       = aws_acm_certificate.expense.arn
}
