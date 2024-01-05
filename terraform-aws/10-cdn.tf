resource "aws_cloudfront_cache_policy" "legacy_cache_policy" {
  name = "gk-legacy-cache-policy"
  default_ttl = 15768000
  min_ttl = 15768000
  max_ttl = 31536000
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "whitelist"
      headers {
        items = ["Origin", "Access-Control-Request-Method", "Access-Control-Request-Headers"]
      }
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}


resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled             = true

  origin {
    domain_name              = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_id                = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
  }
  is_ipv6_enabled     = false


  default_cache_behavior {
    viewer_protocol_policy = "allow-all"
   # path_pattern     = "/*"
    compress         = true
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    cache_policy_id  = aws_cloudfront_cache_policy.legacy_cache_policy.id
    }


  price_class = "PriceClass_All"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

