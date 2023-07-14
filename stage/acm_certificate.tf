# data "aws_acm_certificate" "www_veriws_net" {
#   provider = aws.north_virginia
#   domain       = var.fqdn

#   # tags = var.tags
# }

resource "aws_acm_certificate" "www_veriws_net" {
  provider                  = aws.north_virginia
  domain_name               = var.fqdn.www
  validation_method         = "DNS"
  subject_alternative_names = [var.fqdn.www]

  key_algorithm = "EC_prime256v1"

  lifecycle {
    create_before_destroy = true
  }
}
