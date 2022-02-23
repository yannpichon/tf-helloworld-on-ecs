resource "aws_security_group" "alb_sg" {
  name        = "${var.app_name}-${var.environment}-alb-sg"
  description = "Authorize HTTP/HTTPS access on the ALB"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-alb-sg"
    environment = var.environment
  }
}

resource "aws_lb" "alb" {
  name               = "${var.app_name}-${var.environment}-alb"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = data.aws_subnet_ids.public_subnets.ids

  tags = {
    Name        = "${var.app_name}-${var.environment}-alb"
    environment = var.environment
  }
}

resource "aws_alb_target_group" "alb_target_group" {
  name        = "${var.app_name}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 2
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-tg"
    environment = var.environment
  }
}

resource "aws_alb_listener" "ecs_alb_http_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-http-listener"
    environment = var.environment
  }
}
