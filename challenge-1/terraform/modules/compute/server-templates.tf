# Compute Resources
# 2 server launch templates - 1 Web and 1 API
# 2 Autoscaling groups - Web and API servers
# 2 Load Balancers - Web and API attached to the autoscaling groups

# TODO: Add securirty group

resource "aws_launch_template" "web_server" {
  name = "WebServer"
  block_device_mappings {
    ebs {
      volume_size = var.web_server_volume_size
    }
  }
  disable_api_termination = true
  ebs_optimized = true
  image_id = var.ec2_ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.web_server_instance_type
  key_name = var.ec2_key_name
  network_interfaces {
    associate_public_ip_address = true
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Webserver"
    }
  }
  user_data = filebase64("${path.module}/sample-server-installation.sh")
}

resource "aws_launch_template" "api_server" {
  name = "APIServer"
  block_device_mappings {
    ebs {
      volume_size = var.api_server_volume_size
    }
  }
  disable_api_termination = true
  ebs_optimized = true
  image_id = var.ec2_ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.api_server_instance_type
  key_name = var.ec2_key_name
  network_interfaces {
    associate_public_ip_address = false
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "APIserver"
    }
  }
  user_data = filebase64("${path.module}/sample-server-installation.sh")
}