# Create a Route 53 hosted zone

resource "aws_route53_zone" "route53-zone" {
  name                     = var.domain-name

  tags                     = {
    Name                   = "${var.project-name}-route53-zone"
  }

  lifecycle {
    create_before_destroy  = true
  }
}

##################################################################

# Create a Route 53 record set

resource "aws_route53_record" "route53-record" {
  zone_id                  = aws_route53_zone.route53-zone.zone_id
  name                     = var.subdomain-name
  type                     = "A"

  alias {
    name                   = var.elb-dns-name
    zone_id                = var.elb-zone-id
    evaluate_target_health = true
  }
}
##################################################################