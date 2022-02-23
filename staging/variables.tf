variable "environment" {
  type        = string
  description = "Nom de l'environnement"
}

variable "vpc_cidr_range" {
  type        = string
  description = "Range IP attribué au VPC"
}

variable "public_subnet" {
  type = map(object({
    availability_zone = string,
    cidr_range        = string
  }))
  description = "Map des subnet publiques dans le VPC"
}

variable "app_name" {
  type        = string
  description = "Nom de l'application"
}

variable "app_image_name" {
  type        = string
  description = "Image de l'application à déployer"
}

variable "app_port" {
  type        = number
  description = "Port de l'application à déployer"
}

variable "app_desired_count" {
  type        = number
  description = "Nombre d'instance de l'application à déployer"
}