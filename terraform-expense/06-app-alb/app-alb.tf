resource "aws_lb" "app-alb" {
  name               = "${var.project_name}-${var.environment}-app-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.app-alb_sg_id.value]
  subnets            = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
  
  enable_deletion_protection = false

 tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-app-alb"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> This is fixed response from app-alb </h1>"
      status_code  = "200"
    }
  }
}