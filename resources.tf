module "vpc" {
  source         = "./modules/vpc"
  service_name   = "sample"
  vpc_cidr_block = "10.0.0.0/16"
  env            = terraform.workspace
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
