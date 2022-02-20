resource "aws_lb" "pass-gen-lb" {
  name               = "pass-gen-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.lb_sg.security_group_id]
  subnets            = [module.vpc.public_subnets[0],module.vpc.public_subnets[1]]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_target_group" "pass-gen-tg" {
  name        = "app-tg"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.pass-gen-lb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pass-gen-tg.arn
  }
}
