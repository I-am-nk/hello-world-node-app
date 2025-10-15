variable "aws_region" {
    default = "ap-south-1"
}

variable "cluster_name" {
    default = "devops_eks"
}

variable "cluster_version" {
    default = "1.29"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

variable "public_subnets" {
    default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
    default = ["10.0.101.0/24", "10.0.102.0/24"] 
}

variable "s3_bucket_name" {
    default = "my-terraform-state-bucket-787"
  
}