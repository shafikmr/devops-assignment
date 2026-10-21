
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = "ap-south-1"
  profile = "devops-assignment"
}


module "ec2_instances" {
  source = "./modules/ec2"

  instances   = var.instances
  environment = var.environment
  owner       = var.owner
}
