locals {
  allowed_envs = ["dev", "stg", "prod"]
  selected_env = contains(local.allowed_envs, terraform.workspace) ? terraform.workspace : (
    error("Invalid workspace '${terraform.workspace}'. Please select one of: dev, stg, prod.")
  )
}

module "vpc" {
  source         = "./modules/vpc"
  service_name   = "sample"
  vpc_cidr_block = "10.0.0.0/16"
  env            = local.selected_env
  vpc_additional_tags = {
    Usage = "sample vpc explanation"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_name" {
  value = module.vpc.vpc_name
}
