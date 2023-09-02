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