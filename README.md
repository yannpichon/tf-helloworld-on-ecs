# tf-helloworld-on-ecs

## Description

Ce projet permet de déployer d'une application sur un cluster ECS.

3 modules sont implémentés :
- Network : déploie le socle réseau de l'infrastructure (VPC, subnet ...)
- ELB : déploie le loadbalancer qui va être utilisé pour exposer l'application
- ECS : déploie le cluster ECS et le service de l'application

Pour un environnement, il faut faire appel à ces 3 modules et fournir les inputs suivants : 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_app_desired_count"></a> [app\_desired\_count](#input\_app\_desired\_count) | Nombre d'instance de l'application à déployer | `number` | n/a | yes |
| <a name="input_app_image_name"></a> [app\_image\_name](#input\_app\_image\_name) | Image de l'application à déployer | `string` | n/a | yes |
| <a name="input_app_name"></a> [app\_name](#input\_app\_name) | Nom de l'application | `string` | n/a | yes |
| <a name="input_app_port"></a> [app\_port](#input\_app\_port) | Port de l'application à déployer | `number` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Nom de l'environnement | `string` | n/a | yes |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | Map des subnet publiques dans le VPC | <pre>map(object({<br>    availability_zone = string,<br>    cidr_range        = string<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_cidr_range"></a> [vpc\_cidr\_range](#input\_vpc\_cidr\_range) | Range IP attribué au VPC | `string` | n/a | yes |

## Next steps

- Gestion de l'autoscalling
- Ajout d'un alias DNS via Route53 et d'un certificat
- ...