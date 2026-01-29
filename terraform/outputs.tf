output "vpc_id" {
  value = aws_vpc.main.id
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs.name
}
