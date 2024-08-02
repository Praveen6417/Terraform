resource "aws_lb" "web-alb" {
  name               = "${var.project_name}-${var.environment}-web-alb"
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.private_subnet_ids.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnet_ids.value)
  
  enable_deletion_protection = false

 tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-web-alb"
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> This is fixed response from web-alb http </h1>"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.web-alb.arn
  port              = "443"
  protocol          = "HTTPS"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/html"
      message_body = "<h1> This is fixed response from web-alb https </h1>"
      status_code  = "200"
    }
  }
}