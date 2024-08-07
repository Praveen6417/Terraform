module "frontend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.project_name}-${var.environment}-frontend"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [ data.aws_ssm_parameter.frontend_sg_id.value ]
  ami = data.aws_ami.ami_id.id
  subnet_id              = local.public_subnet_ids

  tags = merge(
    var.common_tags,
    {
      Name = "${var.project_name}-${var.environment}-frontend"
    }
  )
}

resource "null_resource" "frontend" {

  triggers = {
    instance_id = module.frontend.id
  }
  
  connection {
    type = "ssh"
    user = "ec2-user"
    password = "DevOps321"
    host = module.frontend.private_ip
  }

  provisioner "file" {
    source = "frontend.sh"
    destination = "/tmp/frontend.sh"
  }

  provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/${var.common_tags.component}.sh",
            "sudo sh /tmp/${var.common_tags.component}.sh ${var.common_tags.component} ${var.environment}"
        ]
    } 
}

resource "aws_ec2_instance_state" "frontend" {
  instance_id = module.frontend.id
  state       = "stopped"

  depends_on = [ null_resource.frontend ]
}

resource "aws_ami_from_instance" "frontend" {
  name = "frontend-ami"
  source_instance_id = module.frontend.id

  depends_on = [ aws_ec2_instance_state.frontend ]
}

resource "null_resource" "frontend_instance" {
  triggers = {
    instance_id = module.frontend.id
  }

  provisioner "local-exec" {
    command = "aws ec2 terminate-instances --instance-ids ${module.frontend.id}"
  }

  depends_on = [ aws_ami_from_instance.frontend ]

}

resource "aws_launch_template" "frontend" {
  name = "${var.project_name}-${var.environment}-frontend"
  image_id = aws_ami_from_instance.frontend.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t3.micro"
  
  update_default_version = true

  vpc_security_group_ids = [ data.aws_ssm_parameter.frontend_sg_id.value ]

   tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.common_tags,
      {
        Name = "${var.project_name}-${var.environment}-${var.common_tags.component}"
      }
    )
  }
}

resource "aws_lb_target_group" "frontend" {
  name        = "frontend-alb-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  health_check {
    protocol = "HTTP"
    path = "/health"
  }
}

resource "aws_autoscaling_group" "frontend" {
  name                      = "frontend-auto-scaling-group"

  launch_template {
    id = aws_launch_template.frontend.id
    version = "$Latest"
  }

  target_group_arns = [ aws_lb_target_group.frontend.arn ]

  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 1

  vpc_zone_identifier       = split(",", data.aws_ssm_parameter.public_subnet_ids.value)

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = "50" #The "min_healthy_percentage" parameter defines the minimum percentage of instances that must remain in a healthy state throughout the refresh process.
    }

    triggers = [ "launch_template" ]
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-${var.common_tags.component}"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = "${var.project_name}"
    propagate_at_launch = false
  }
}

resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.frontend.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 10.0
  }
}

# resource "aws_lb_listener_rule" "frontend" {
#   listener_arn = data.aws_ssm_parameter.web-alb-aws_lb_listener.value
#   priority     = 100 # less number will be first validated

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.frontend.arn
#   }

#   condition {
#     source_ip {
#       values = [module.frontend.public_ip]  # Replace with your IP address
#     }
#   }
# }