resource "aws_acm_certificate" "cert" {
  domain_name       = "matthewmcgowan.co.uk"
  subject_alternative_names = ["www.matthewmcgowan.co.uk"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# resource "aws_acm_certificate_validation" "cert" {
#   certificate_arn         = aws_acm_certificate.cert.arn

#   validation_record_fqdns = [
#       aws_route53_record.www.fqdn,
#       aws_route53_record.tld.fqdn
#     ]
# }
