locals {
  ecs_cluster_tags = merge(
    var.cluster_additional_tags,
    {
      "ServiceName" = var.service_name
      "Env"         = var.env
    }
  )
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.service_name}-${var.env}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = local.ecs_cluster_tags
}

resource "aws_ecs_cluster_capacity_providers" "cluster_capacity_provider" {
  cluster_name       = aws_ecs_cluster.cluster.name
  capacity_providers = ["FARGATE"]
}

output "cluster_name" {
  description = "作成されたクラスターの名前"
  value       = aws_ecs_cluster.cluster.name
}

output "cluster_arn" {
  description = "作成されたクラスターのARN"
  value       = aws_ecs_cluster.cluster.arn
}
