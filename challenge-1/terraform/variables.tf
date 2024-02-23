variable "region" {
    default = "us-east-1"
}
variable "availability_zone_list" {
}
variable "vpc_cidr_block" {
}

variable "private_subnet_cidr_block" {
}

variable "public_subnet_cidr_block" {
}

variable "public_subnet_az" {
}

variable "private_subnet_az" {
}

variable "web_server_volume_size" {
}

variable "api_server_volume_size" {}
variable "web_server_instance_type" {}
variable "api_server_instance_type" {}
variable "ec2_key_name" {}
variable "ec2_ami_id" {}