# On recupère la Route 53 hosted Zone 

data "aws_route53_zone" "zeeward41_hosted_zone" {
    name = var.url_name
}


resource "aws_route53_record" "zeeward41_cert_dns" {
    allow_overwrite = true
    name = tolist(aws_acm_certificate.zeeward41_acm.domain_validation_options)[0].resource_record_name

    records = [tolist(aws_acm_certificate.zeeward41_acm.domain_validation_options)[0].resource_record_value]

    type = tolist(aws_acm_certificate.zeeward41_acm.domain_validation_options)[0].resource_record_type
    
    zone_id = data.aws_route53_zone.zeeward41_hosted_zone.zone_id
    ttl = 60
}

resource "aws_route53_record" "record_zeeward41" {
    zone_id = data.aws_route53_zone.zeeward41_hosted_zone.zone_id
    name = var.url_name
    type = "A"
    alias {
        name = aws_cloudfront_distribution.s3_distribution.domain_name
        zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
        evaluate_target_health = false
    }
}