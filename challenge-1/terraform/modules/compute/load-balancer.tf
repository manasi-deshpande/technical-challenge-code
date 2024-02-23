#TODO: Add Security group
resource "aws_lb" "web_alb" {
    name = "Web-LoadBalancer"
    subnets = var.public_subnet_id
    internal           = false
    load_balancer_type = "application"
}
resource "aws_lb" "api_alb" {
    name = "API-LoadBalancer"
    subnets = var.private_subnet_id
    internal           = true
    load_balancer_type = "application"
}