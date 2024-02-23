# TODO: add a policy

data "aws_default_tags" "current" {}
data "aws_availability_zones" "available" {}
resource "aws_autoscaling_group" "webserver" {
  vpc_zone_identifier = []
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.web_server.id
    version = "$Latest"
  }
  target_group_arns = [aws_lb.web_alb.arn]

  dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
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

resource "aws_autoscaling_group" "apiserver" {
  vpc_zone_identifier = []
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  target_group_arns = [aws_lb.api_alb.arn]

  launch_template {
    id      = aws_launch_template.api_server.id
    version = "$Latest"
  }

  dynamic "tag" {
    for_each = data.aws_default_tags.current.tags
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
