# -------------------------------
# Variables
# -------------------------------
variable "cluster_name" {}
variable "vpc_cidr" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "aws_region" {}

# -------------------------------
# VPC Module
# -------------------------------
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = "${var.cluster_name}-vpc"
  cidr = var.vpc_cidr

  # Availability Zones
  azs = ["${var.aws_region}a", "${var.aws_region}b"]

  # Subnets
  # We'll make the first subnet public and attach an Internet Gateway
  public_subnets  = var.public_subnets     # Example: ["10.0.101.0/24"]
  private_subnets = var.private_subnets    # Example: ["10.0.1.0/24", "10.0.2.0/24"]

  # Enable NAT for private subnets and IGW for public subnet
  enable_nat_gateway     = true
  single_nat_gateway     = true
  enable_dns_support     = true
  enable_dns_hostnames   = true
  map_public_ip_on_launch = true  # ✅ ensures EC2 in public subnet gets public IP

  # Tags
  tags = {
    Name = "${var.cluster_name}-vpc"
  }
}

# -------------------------------
# Outputs
# -------------------------------
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}
