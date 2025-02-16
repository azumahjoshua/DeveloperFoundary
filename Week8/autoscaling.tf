resource "random_id" "instance_suffix" {
  byte_length = 2
}

resource "aws_autoscaling_group" "tomcat_asg" {
  desired_capacity    = 2
  max_size            = 3
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  launch_template {
    id      = aws_launch_template.tomcat_lt.id
    version = aws_launch_template.tomcat_lt.latest_version
  }

  target_group_arns = [aws_lb_target_group.tomcat_tg.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300
  tag {
    key                 = "Name"
    value               = "Tomcat-Instance-${random_id.instance_suffix.hex}"
    propagate_at_launch = true
  }

}
