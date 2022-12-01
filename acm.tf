data "aws_acm_certificate" "issued" {
  count    = var.certificate_arn == null ? 1 : 0
  domain   = join(".", [var.host, data.aws_route53_zone.zone.name])
  statuses = ["ISSUED"]
}