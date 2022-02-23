environment    = "production"
vpc_cidr_range = "10.1.0.0/16"
public_subnet = {
  public-subnet-1 = {
    availability_zone = "eu-west-3a"
    cidr_range        = "10.1.0.0/24"
  },
  public-subnet-2 = {
    availability_zone = "eu-west-3b"
    cidr_range        = "10.1.1.0/24"
  }
}

app_name          = "helloworld"
app_image_name    = "digitalocean/flask-helloworld"
app_port          = 5000
app_desired_count = 3