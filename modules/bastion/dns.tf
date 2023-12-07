resource "aws_route53_record" "bastion" {
  count   = var.dns_name != "" ? 1 : 0
  zone_id = var.dns_zone_id
  name    = var.dns_name
  type    = "CNAME"
  ttl     = 300
  records = [aws_instance.bastion.public_dns]
}
