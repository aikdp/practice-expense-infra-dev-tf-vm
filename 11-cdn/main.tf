# resource "aws_s3_bucket" "b" {
#   bucket = "mybucket"

#   tags = {
#     Name = "My bucket"
#   }
# }

# resource "aws_s3_bucket_acl" "b_acl" {
#   bucket = aws_s3_bucket.b.id
#   acl    = "private"
# }

# locals {
#   s3_origin_id = "myS3Origin"
# }

resource "aws_cloudfront_distribution" "expense" {
  origin {
    domain_name              = "${var.project}-${var.environment}.${var.zone_name}"
    # origin_access_control_id = aws_cloudfront_origin_access_control.default.id
    origin_id                = "${var.project}-${var.environment}.${var.zone_name}"     #expense-dev.telugudevops.online

       custom_origin_config{
        http_port = 80
        https_port = 443
        origin_protocol_policy = "https-only"
        origin_ssl_protocols = ["TLSv1.2"]
    }
  }

  enabled             = true


  aliases = ["${var.project}-${var.module_name}.${var.zone_name}"]  #expense-cdn.telugudevops.online

#dynamic content so, not cache
  default_cache_behavior {
    cache_policy_id  = data.aws_cloudfront_cache_policy.nocache.id  #Not cache deafult content, means dynamic content no cache, eg: db data

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project}-${var.environment}.${var.zone_name}" 


    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400


  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
   
    path_pattern     = "/images/*"
    cache_policy_id  = data.aws_cloudfront_cache_policy.cacheOptimised.id   #cache images
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "${var.project}-${var.environment}.${var.zone_name}"

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  # Cache behavior with precedence 1
  ordered_cache_behavior {
    path_pattern     = "/static/*"
    cache_policy_id  = data.aws_cloudfront_cache_policy.cacheOptimised.id   #cache the static content
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.project}-${var.environment}.${var.zone_name}"


    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    # compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "IN"]
    }
  }

  tags = {
    Name  = local.resource_name
  }

  viewer_certificate {
    acm_certificate_arn = local.acm_https_cert_arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method = "sni-only"
  }
}


#Records for CDN CloudFront
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"

  zone_name = var.zone_name

  records = [
    {
      name    = "${var.project}-${var.module_name}"  # .app-dev.telugudevops.online
      type    = "A"
      alias   = {
        name    = aws_cloudfront_distribution.expense.domain_name     # domain_name - Domain name corresponding to the distribution. 
                                                                        #For example: d604721fxaaqy9.cloudfront.net.
        zone_id = aws_cloudfront_distribution.expense.hosted_zone_id  # This belongs CloudFront internal hosted zone, not ours
      }
      allow_overwrite = true
    },
  ]
}