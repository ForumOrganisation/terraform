resource "aws_cloudfront_distribution" "default" {
  origin {
    domain_name = "${var.domain_name}"
    origin_id   = "${var.app_name}-${var.app_environment}"
  }

  enabled             = true
  is_ipv6_enabled     = true

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.app_name}-${var.app_environment}"
    compress = true

    forwarded_values {
      query_string = true
      query_string_cache_keys = ["t"]

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags {
    Name = "${var.app_name}"
    Environment = "${var.app_environment}"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
