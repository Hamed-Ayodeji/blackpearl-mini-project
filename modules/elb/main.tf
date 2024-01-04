# create an elastic load balancer

resource "aws_lb" "elb" {
  name                     = "${var.project-name}-elb"
  internal                 = false
  load_balancer_type       = "application"
  security_groups          = [var.elb-sg-id]
  subnets                  = [var.subnet-ids[0], var.subnet-ids[1], var.subnet-ids[2]]
  tags                     = {
    Name                   = "${var.project-name}-elb"
  }
}

##################################################################

# create a target group

resource "aws_lb_target_group" "elb-tg" {
  name                     = "${var.project-name}-elb-tg"
  target_type              = "ip"
  port                     = 80
  protocol                 = "HTTP"
  vpc_id                   = var.vpc-id
  tags                     = {
    Name                   = "${var.project-name}-elb-tg"
  }

  health_check {
    enabled                = true
    healthy_threshold      = 5
    unhealthy_threshold    = 5
    timeout                = 60
    interval               = 300
    path                   = "/"
    matcher                = 200
  }

  lifecycle {
    create_before_destroy  = true
  }
}

##################################################################

# register targets

resource "aws_lb_target_group_attachment" "elb-tg-attachment" {
  for_each = toset(var.instance_ids)

  target_group_arn = aws_lb_target_group.elb-tg.arn
  target_id        = each.value
  port             = 80
}

##################################################################

# create a listener

resource "aws_lb_listener" "elb-listener" {
  load_balancer_arn        = aws_lb.elb.arn
  port                     = 80
  protocol                 = "HTTP"

  default_action {
    target_group_arn       = aws_lb_target_group.elb-tg.arn
    type                   = "forward"
  }
}

##################################################################

# Create a Route 53 hosted zone

resource "aws_route53_zone" "route53-zone" {
  name                     = var.domain-name

  tags                     = {
    Name                   = "${var.project-name}-route53-zone"
  }
}

##################################################################

# Create a Route 53 record set

resource "aws_route53_record" "route53-record" {
  zone_id                  = aws_route53_zone.route53-zone.zone_id
  name                     = "terraform-test.${var.domain-name}"
  type                     = "A"
  ttl                      = "300"
  records                  = [aws_lb.elb.dns_name]
}

##################################################################