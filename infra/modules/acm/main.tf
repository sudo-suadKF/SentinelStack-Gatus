resource "aws_acm_certificate" "cert-HTTPS" {
  domain_name       = var.domain-name
  validation_method = var.validation-method

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "HTTPS-validation-cert" {
  certificate_arn         = aws_acm_certificate.cert-HTTPS.arn
  validation_record_fqdns = [for record in aws_route53_record.validation : record.fqdn]
}

data "aws_route53_zone" "my-hosted-zone" {
  name         = var.hosted-zone-name
  private_zone = false
}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.cert-HTTPS.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.record-ttl
  type            = each.value.type
  zone_id         = data.aws_route53_zone.my-hosted-zone.zone_id
}