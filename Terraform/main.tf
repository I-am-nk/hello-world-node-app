terraform {
  
  required_version = ">=1.3.0"

    backend "s3" {
      bucket = "my-terraform-state-bucket-787"
      key    = "eks/terraform.tfstate"
      region = "ap-south-1"
      encrypt = true
    }

    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./Modules/VPC"

  cluster_name    = var.cluster_name
  vpc_cidr       = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
  aws_region      = var.aws_region
}

module "eks" {
  source = "./Modules/EKS"

  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  cluster_version = var.cluster_version
}
