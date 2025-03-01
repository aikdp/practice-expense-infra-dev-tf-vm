#cache policy id
data "aws_cloudfront_cache_policy" "nocache" {
  name = "Managed-CachingDisabled"
}
#cache policy id for Cacheing
data "aws_cloudfront_cache_policy" "cacheOptimised" {
  name = "Managed-CachingOptimized"
}

#SSM
data "aws_ssm_parameter" "acm_https_cert_arn" {
  name = "/${var.project}/${var.environment}/acm_https_cert_arn"
}
