resource "aws_lb" "load_balancer" {
  name               = format("%s-load-balancer", var.app_name)
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet.id]
}

resource "aws_lb_target_group" "lb_group" {
  name        = format("%s-lb-group", var.app_name)
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"
}

resource "aws_lb_target_group_attachment" "example" {
  target_group_arn = aws_lb_target_group.lb_group.arn
  target_id        = aws_ecs_service.service_entrypoint.id
  port             = 80
}