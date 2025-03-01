locals {
  resource_name = "${var.project}-${var.environment}"
  my_zone_id = data.aws_route53_zone.expense.zone_id
}