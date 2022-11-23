## ALB
module "s3_bucket" {
  source        = "terraform-aws-modules/s3-bucket/aws"
  create_bucket = var.expose ? true : false
  bucket        = local.alb_logs_bucket
  acl           = "log-delivery-write"

  attach_elb_log_delivery_policy        = true
  attach_lb_log_delivery_policy         = true
  attach_deny_insecure_transport_policy = true
  attach_require_latest_tls_policy      = true

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true


}

resource "aws_lb" "main" {
  count              = var.expose ? 1 : 0
  load_balancer_type = "application"
  internal           = false
  name               = local.alb_prefix
  subnets            = var.subnet_ids
  security_groups    = [aws_security_group.app.id]

  access_logs {
    prefix  = "${local.alb_prefix}-access-logs"
    enabled = true
    bucket  = module.s3_bucket.s3_bucket_id
  }
}

resource "aws_alb_listener" "endpoint" {
  count             = var.expose ? 1 : 0
  load_balancer_arn = aws_lb.main[0].id
  port              = var.container_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.target_group[count.index].id
    type             = "forward"
  }
}

resource "aws_alb_target_group" "target_group" {
  count       = var.expose ? 1 : 0
  name        = "${local.alb_prefix}-tg"
  port        = var.container_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}


resource "aws_route53_record" "backend" {
  count          = var.expose ? 1 : 0
  name           = var.host
  type           = "CNAME"
  zone_id        = var.zone_id
  set_identifier = coalesce(var.record_set_identifier, terraform.workspace)
  ttl            = 360
  records        = [aws_lb.main[0].dns_name]

  weighted_routing_policy {
    weight = 10
  }
}