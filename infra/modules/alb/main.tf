# ALB
resource "aws_lb" "alb-gatus" {
  name               = var.alb-name
  internal           = false
  load_balancer_type = var.lb-type
  security_groups    = [var.alb-sg-id]
  subnets            = [var.public-subnet1-id, var.public-subnet2-id, var.public-subnet3-id]
  drop_invalid_header_fields = true

  access_logs {
    bucket  = var.bucket-name
    prefix  = var.logs-prefix
    enabled = true
  }

  tags = {
    Name = var.alb-tags
  }
}

# Target Group
resource "aws_lb_target_group" "ecs-tg" {
  name     = var.tg-name
  port     = var.tg-port
  protocol = var.tg-protocol
  ip_address_type = var.tg-ip-type
  vpc_id   = var.vpc-id
  target_type = var.tg-target-type

  health_check {
    healthy_threshold   = var.healthy-threshold
    interval            = var.health-check-interval
    protocol            = var.health-check-protocol
    matcher             = var.health-check-matcher
    timeout             = var.health-check-timeout
    path                = var.health-check-path
    unhealthy_threshold = var.health-check-unhealthy-threshold
    port                = var.health-check-port
  }
}
########################################################################

#ALB's HTTP and HTTPS listeners
resource "aws_lb_listener" "HTTP_listener" {
  load_balancer_arn = aws_lb.alb-gatus.arn
  port              = var.listener-http-port
  protocol          = var.listener-http-protocol

  default_action {
    type             = var.listener-http-action-type

    redirect {
      port        = var.listener-http-action-port
      protocol    = var.listener-http-action-protocol
      status_code = var.listener-http-action-status-code
    }
  }
}

resource "aws_lb_listener" "HTTPS_listener" {
  load_balancer_arn = aws_lb.alb-gatus.arn
  port              = var.listener-https-port
  protocol          = var.listener-https-protocol
  ssl_policy        = var.listener-https-ssl-policy
  certificate_arn   = var.certificate-arn

  default_action {
    type             = var.listener-https-action-type
    target_group_arn = aws_lb_target_group.ecs-tg.arn
  }
}