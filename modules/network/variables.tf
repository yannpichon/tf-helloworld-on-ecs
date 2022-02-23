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
  description = "Map des subnet publics dans le VPC"
}