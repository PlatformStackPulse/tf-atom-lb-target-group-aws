resource "aws_lb_target_group" "this" {
  count = module.this.enabled ? 1 : 0

  name        = module.this.id
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  deregistration_delay = var.deregistration_delay

  health_check {
    enabled             = true
    path                = var.health_check_path
    port                = var.health_check_port
    protocol            = var.health_check_protocol
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    timeout             = var.health_check_timeout
    interval            = var.health_check_interval
    matcher             = var.health_check_matcher
  }

  tags = module.this.tags
}
