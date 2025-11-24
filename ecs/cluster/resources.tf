module "ecs_cluster" {
  source = "../../modules/ecs/cluster"

  service_name = "sample"
  env          = terraform.workspace
}

output "ecs_cluster_name" {
  value = module.ecs_cluster.cluster_name
}

output "ecs_cluster_arn" {
  value = module.ecs_cluster.cluster_arn
}
