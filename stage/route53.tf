data "aws_route53_zone" "veriws_net" {
  name         = "veriws.net."
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.veriws_net.zone_id
  name    = var.fqdn.www
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront.hosted_zone_id 
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "dns_verification_www_veriws_net" {
  zone_id = data.aws_route53_zone.veriws_net.zone_id
  # name    = aws_acm_certificate.www_veriws_net.domain_validation_options.resource_record_name
  # type    = aws_acm_certificate.www_veriws_net.domain_validation_options[0].resource_record_type
  ttl     = 300
  # records = [aws_acm_certificate.www_veriws_net.domain_validation_options[0].resource_record_value]

  # dynamic "record" {
  #   for_each = aws_acm_certificate.www_veriws_net.domain_validation_options
  #   content {
  #     name    = record.value.resource_record_name
  #     type    = record.value.resource_record_type
  #     ttl     = "300"
  #     records = [record.value.resource_record_value]
  #   }
  # }
  depends_on = [
    aws_acm_certificate.www_veriws_net
  ]

  for_each = {
    for cert_parameter in aws_acm_certificate.www_veriws_net.domain_validation_options : cert_parameter.domain_name => {
      name   = cert_parameter.resource_record_name
      record = cert_parameter.resource_record_value
      type   = cert_parameter.resource_record_type
    }
  }

  name            = each.value.name
  type            = each.value.type
  records         = [each.value.record]
}
