variable "cluster_name" {}
variable "vpc_cidr" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "aws_region" {}

module "vpc" {
    source  = "terraform-aws-modules/vpc/aws"
    version = "4.0.2"

    name = "${var.cluster_name}-vpc"
    cidr = var.vpc_cidr

    azs             = ["${var.aws_region}a", "${var.aws_region}b"]
    public_subnets  = var.public_subnets
    private_subnets = var.private_subnets

    enable_nat_gateway = true
    single_nat_gateway = true

    tags = {
        Name = "${var.cluster_name}-vpc"
    }
  
}

output "vpc_id" {
    value = module.vpc.vpc_id
  
}

output "private_subnets" {
    value = module.vpc.private_subnets
}