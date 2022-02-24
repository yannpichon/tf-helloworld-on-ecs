variable "environment" {
  type        = string
  description = "Nom de l'environnement"
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