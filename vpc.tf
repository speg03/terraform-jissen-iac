resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = merge(var.vpc_additional_tags, {
    Name = var.vpc_name
    Env  = var.env
  })
}
