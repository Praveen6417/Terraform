resource "aws_ssm_parameter" "app_alb" {
  name = "/${var.project_name}/${var.environment}/app-alb"
  type = "String"
  value = aws_lb.app-alb.arn
}

resource "aws_ssm_parameter" "app-alb-aws_lb_listener" {
  name = "/${var.project_name}/${var.environment}/app-alb-listener"
  type = "String"
  value = aws_lb_listener.http.arn
}