data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.environment}"]
  }
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:type"
    values = ["public-subnet"]
  }
}

data "aws_security_group" "alb_sg" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-${var.environment}-alb-sg"]
  }
}

data "aws_lb_target_group" "tg" {
  name = "${var.app_name}-${var.environment}-tg"
}