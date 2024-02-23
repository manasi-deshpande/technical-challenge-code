module "networking" {
  source = "./modules/networking"
  vpc_cidr_block = var.vpc_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  public_subnet_az = var.public_subnet_az
  private_subnet_az = var.private_subnet_az
  availability_zone_list = var.availability_zone_list
}

# module "iam" {
#   source = "./modules/iam"
# }

module "compute" {
  source = "./modules/compute"
  web_server_volume_size = var.web_server_volume_size
  api_server_volume_size = var.api_server_volume_size
  web_server_instance_type = var.web_server_instance_type
  api_server_instance_type = var.api_server_instance_type
  ec2_key_name = var.ec2_key_name
  ec2_ami_id = var.ec2_ami_id
  public_subnet_id = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  public_subnet_az = var.public_subnet_az
  private_subnet_az = var.private_subnet_az
  availability_zone_list = var.availability_zone_list
}

# module "database" {
#   source = "modules/database"
# }
