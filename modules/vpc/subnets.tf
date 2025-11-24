locals {
  public_subnet_az_mapping = {
    for cidr in var.subnet_cidrs.public :
    cidr => data.aws_availability_zones.availability_zones.names[
      index(var.subnet_cidrs.public, cidr) % local.number_of_availability_zones
    ]
  }
}

resource "aws_subnet" "public_subnets" {
  for_each = toset(var.subnet_cidrs.public)

  cidr_block = each.key
  vpc_id     = aws_vpc.vpc.id

  availability_zone = local.public_subnet_az_mapping[each.key]

  tags = merge(
    var.subnet_additional_tags,
    {
      Name             = "${var.service_name}-${var.env}-${local.public_subnet_az_mapping[each.key]}-public-subnet"
      Env              = var.env
      Scope            = "public"
      AvailabilityZone = local.public_subnet_az_mapping[each.key]
    }
  )
}

locals {
  private_subnet_az_mapping = {
    for cidr in var.subnet_cidrs.private :
    cidr => data.aws_availability_zones.availability_zones.names[
      index(var.subnet_cidrs.private, cidr) % local.number_of_availability_zones
    ]
  }
}

resource "aws_subnet" "private_subnets" {
  for_each = toset(var.subnet_cidrs.private)

  cidr_block = each.key
  vpc_id     = aws_vpc.vpc.id

  availability_zone = local.private_subnet_az_mapping[each.key]

  tags = merge(
    var.subnet_additional_tags,
    {
      Name             = "${var.service_name}-${var.env}-${local.private_subnet_az_mapping[each.key]}-private-subnet"
      Env              = var.env
      Scope            = "private"
      AvailabilityZone = local.private_subnet_az_mapping[each.key]
    }
  )
}
