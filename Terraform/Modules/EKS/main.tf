variable "cluster_name" {}
variable "vpc_id" {}
variable "private_subnets" {}
variable "cluster_version" {}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.2.1"

  # --- Cluster Configuration ---
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.private_subnets

  # --- EKS Managed Node Group ---
  eks_managed_node_groups = {
    default = {
      desired_size   = 1
      max_size       = 1
      min_size       = 1
      instance_types = ["t3.micro"]

      # Attach IAM Policies required for node group
      iam_role_additional_policies = {
        AmazonEKSWorkerNodePolicy          = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEKS_CNI_Policy               = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
      }
    }
  }

  tags = {
    Environment = "dev"
    Name        = var.cluster_name
  }
}

# --- Outputs ---
output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_role_name" {
  value = module.eks.eks_managed_node_groups["default"].iam_role_name
}
