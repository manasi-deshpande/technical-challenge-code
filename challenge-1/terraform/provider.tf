terraform {
  backend "s3" {
  }
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.37.0"
    }
  }
}

provider "aws" {
    region = var.region
    default_tags {
        tags = {
            Name = "KPMG-Challenge-1"
        }
    }
}
