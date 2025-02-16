resource "aws_lb" "public_alb" {
  name               = "public-tomcat-alb"
  internal           = false # Public-facing
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "public-tomcat-alb"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tomcat_tg.arn
  }
}

resource "aws_autoscaling_attachment" "tomcat_web_server" {
  autoscaling_group_name = aws_autoscaling_group.tomcat_asg.name
  lb_target_group_arn    = aws_lb_target_group.tomcat_tg.arn

}