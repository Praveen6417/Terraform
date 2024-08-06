resource "aws_ssm_parameter" "web_alb" {
  name = "/${var.project_name}/${var.environment}/web-alb"
  type = "String"
  value = aws_lb.web-alb.arn
}

resource "aws_ssm_parameter" "web-alb-aws_lb_listener" {
  name = "/${var.project_name}/${var.environment}/web-alb-listener"
  type = "String"
  value = aws_lb_listener.http.arn
}