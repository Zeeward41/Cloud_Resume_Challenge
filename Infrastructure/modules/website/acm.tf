# Creation d'un certificate (ACM pour l'alternate domain name)
resource "aws_acm_certificate" "zeeward41_acm" {
    domain_name = var.url_name
    validation_method = "DNS"

    //spécifie la region global pour le certificate
    provider = aws.global

    lifecycle {
        create_before_destroy = true
    }
}

# Validation via DNS du certificate

resource "aws_acm_certificate_validation" "zeeward41_cert_validate" {
    provider = aws.global
    certificate_arn = aws_acm_certificate.zeeward41_acm.arn
    validation_record_fqdns = [aws_route53_record.zeeward41_cert_dns.fqdn]
}