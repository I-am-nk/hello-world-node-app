##############################################
# Variables
##############################################
variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" {}
variable "cluster_version" {}

##############################################
# IAM Data Source for EC2 Bastion Role
##############################################
data "aws_iam_role" "ec2_eks" {
  name = "ec2_eks"
}

##############################################
# EKS Module (terraform-aws-modules/eks/aws v20.2.1)
##############################################
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.2.1"

  # --- Cluster Configuration ---
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  # --- Cluster Endpoint Access Configuration (v20.2.1 syntax) ---
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = false

  # ✅ The variable name changed — use "cluster_endpoint_public_access_cidrs"
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]

  # --- Managed Node Group ---
  eks_managed_node_groups = {
    default = {
      desired_size   = 1
      max_size       = 1
      min_size       = 1
      instance_types = ["t3.micro"]

      iam_role_additional_policies = {
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }

  # --- Authentication Mapping (v20.2.1 syntax) ---
  authentication_mode = "API"  # required when using access_entries instead of map_roles

  access_entries = {
    ec2_bastion = {
      principal_arn = data.aws_iam_role.ec2_eks.arn

      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  tags = {
    Environment = "dev"
    Name        = var.cluster_name
  }
}

##############################################
# Outputs
##############################################
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_role_name" {
  value = module.eks.eks_managed_node_groups["default"].iam_role_name
}
