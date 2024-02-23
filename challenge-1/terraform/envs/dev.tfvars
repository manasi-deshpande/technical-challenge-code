region = "us-east-1"
availability_zone_list = ["us-east-1-a", "us-east-1-b"]
vpc_cidr_block = "10.2.0.0/16"
private_subnet_cidr_block = "10.2.1.0/24"
public_subnet_cidr_block = "10.2.2.0/24"
public_subnet_az = "us-east-1-a"
private_subnet_az = "us-east-1-a"
web_server_volume_size = 20
api_server_volume_size = 20
web_server_instance_type = "t2.micro"
api_server_instance_type = "t2.micro"
ec2_key_name = "mykey"
ec2_ami_id = "ami-0440d3b780d96b29d"