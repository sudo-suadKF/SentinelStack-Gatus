data "aws_route53_zone" "my-hosted-zone" {
  name         = var.hosted-zone-name
  private_zone = false
}

resource "aws_route53_record" "alb-domain-record" {
  zone_id = data.aws_route53_zone.my-hosted-zone.zone_id
  name    = var.domain-name
  type    = var.record-type

  alias {
    name = var.alb-dns-name
    zone_id =  var.alb-zone-id
    evaluate_target_health = true
  }
}
