data "aws_route53_zone" "matthewmcgowan_co_uk" {
  name         = "matthewmcgowan.co.uk"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.matthewmcgowan_co_uk.zone_id
  name    = "www.matthewmcgowan.co.uk"
  type    = "A"

  alias {
    name                   = "d2l0l0u73otsy6.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "tld" {
  zone_id = data.aws_route53_zone.matthewmcgowan_co_uk.zone_id
  name    = "matthewmcgowan.co.uk"
  type    = "A"
  
  alias {
    name                   = "d2l0l0u73otsy6.cloudfront.net"
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}
