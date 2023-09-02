# Creation de la distribution avec CloudFront

resource "aws_cloudfront_distribution" "s3_distribution" {
    default_cache_behavior {
        allowed_methods = ["GET", "HEAD"]
        cached_methods = ["GET", "HEAD"]
        cache_policy_id = aws_cloudfront_cache_policy.zeeward41_cache_policy.id
        target_origin_id = local.s3_origin_id
        viewer_protocol_policy = "redirect-to-https"
        compress = true
}
    //Object that you want CloudFront to return (for example, index.html)
    // when an end user requests the root URL.
    default_root_object = "index.html"

    //Whether the distribution is enabled to accept end user requests for content.
    enabled = true

    origin {
        // Static Website url
        domain_name = aws_s3_bucket.bucket_base.bucket_regional_domain_name
        //aws_s3_bucket_website_configuration.bucket_website.website_endpoint
        origin_id = local.s3_origin_id
        origin_access_control_id = aws_cloudfront_origin_access_control.zeeward41_origin_access_control.id

    }

    

    //aucune restriction pour les edges locations.
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    //certificate viewer
    viewer_certificate {
        ssl_support_method = "sni-only"
        acm_certificate_arn = aws_acm_certificate.zeeward41_acm.arn
    }

    //alternate domaine name
    aliases = [var.url_name]

}



# Creation d'un cache policy

resource "aws_cloudfront_cache_policy" "zeeward41_cache_policy" {
    name = "zeeward41_cache_policy"
    min_ttl = 1
    max_ttl = 31536000
    default_ttl = 86400

    parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}



# Creation Origin access control

resource "aws_cloudfront_origin_access_control" "zeeward41_origin_access_control" {

    name = "zeeward41_origin_access_control"
    origin_access_control_origin_type = "s3"
    signing_behavior = "always"
    signing_protocol = "sigv4"
}