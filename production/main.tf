module "network" {
  source = "../modules/network"

  environment    = var.environment
  vpc_cidr_range = var.vpc_cidr_range
  public_subnet  = var.public_subnet
}

module "elb" {
  source = "../modules/elb"

  environment = var.environment
  app_name    = var.app_name

  depends_on = [module.network]
}

module "ecs" {
  source = "../modules/ecs"

  environment       = var.environment
  app_name          = var.app_name
  app_image_name    = var.app_image_name
  app_port          = var.app_port
  app_desired_count = var.app_desired_count

  depends_on = [module.elb]
}