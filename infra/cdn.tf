resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.staticFiles.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.staticFiles.bucket_regional_domain_name
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases = ["www.matthewmcgowan.co.uk", "matthewmcgowan.co.uk"]
  price_class = "PriceClass_100"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.staticFiles.bucket_regional_domain_name
    //cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    cache_policy_id = data.aws_cloudfront_cache_policy.default_caching_optimised.id
    compress = true
    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = aws_acm_certificate.cert.arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.1_2016"
  }
}

data "aws_cloudfront_cache_policy" "default_caching_optimised" {
  name = "Managed-CachingOptimized"
}
