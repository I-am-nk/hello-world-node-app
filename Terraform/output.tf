output "vpc_id" {
    value = module.vpc.vpc_id
}

output "cluster_name" {
    value = module.eks.cluster_name
}

output "kubeconfig_command" {
    value = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region ${var.aws_region}"
  
}