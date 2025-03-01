
data "aws_route53_zone" "expense" {
  name         = var.zone_name
  private_zone = false
}