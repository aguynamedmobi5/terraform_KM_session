resource "aws_autoscaling_group" "web" {
  name             = "WebServer-Highly-Available-ASG-Ver-${aws_launch_template.web.latest_version}"
  min_size         = 2
  max_size         = 4
  desired_capacity = 3
  health_check_type         = "EC2"
  wait_for_capacity_timeout = 0
  health_check_grace_period = 300
  vpc_zone_identifier       = [data.aws_subnet.subnet1.id, data.aws_subnet.subnet2.id]
  target_group_arns         = [aws_lb_target_group.web.arn]

  launch_template {
    id      = aws_launch_template.web.id
    version = aws_launch_template.web.latest_version
  }

  dynamic "tag" {
    for_each = {
      Name   = "WebServer in ASG"
      TAGKEY = "TAGVALUE"
    }
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}