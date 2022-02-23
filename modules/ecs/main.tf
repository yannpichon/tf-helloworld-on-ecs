resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.app_name}-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  capacity_providers = ["FARGATE"]

  tags = {
    Name        = "${var.app_name}-${var.environment}-ecs-cluster"
    environment = var.environment
  }
}

resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.app_name}-${var.environment}"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048

  container_definitions = jsonencode([
    {
      name      = var.app_name
      image     = var.app_image_name
      essential = true
      portMappings = [
        {
          containerPort = var.app_port
          hostPort      = var.app_port
        }
      ]
    }
  ])
}

resource "aws_security_group" "ecs_sg" {
  name        = "${var.app_name}-${var.environment}-ecs-service-security-group"
  description = "Authorize HTTP/HTTPS access from the ALB"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port       = 80
    to_port         = var.app_port
    protocol        = "tcp"
    security_groups = [data.aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-ecs-sg"
    environment = var.environment
  }
}

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.app_name}-${var.environment}-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = var.app_desired_count

  network_configuration {
    subnets          = data.aws_subnet_ids.public_subnets.ids
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = data.aws_lb_target_group.tg.arn
    container_name   = var.app_name
    container_port   = var.app_port
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-ecs-service"
    environment = var.environment
  }
}