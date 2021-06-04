resource "aws_autoscaling_group" "web_asg" {
  name                = "${var.env}_web_asg"
  max_size            = 3
  min_size            = 1
  desired_capacity    = 1
  health_check_type   = "ELB"
  force_delete        = true
  target_group_arns   = [aws_lb_target_group.web_tg.arn]
  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnets_ids

  launch_template {
    id      = aws_launch_template.web_template.id
    version = aws_launch_template.web_template.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.env}_wordpress"
    propagate_at_launch = true
  }

  dynamic "tag" {
    for_each = local.common_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

resource "aws_autoscaling_attachment" "web_lb_asg_attachment" {
  alb_target_group_arn   = aws_lb_target_group.web_tg.arn
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
}