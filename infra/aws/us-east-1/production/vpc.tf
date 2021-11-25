module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs              = var.vpc_azs
  private_subnets  = var.vpc_private_subnets
  public_subnets   = var.vpc_public_subnets
  database_subnets = var.vpc_database_subnets

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = var.vpc_tags
}



/*
data "aws_vpc" "main" {
  default = false 
  tags = {
    Name = var.vpc_name
  }
}*/

/*data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Tier = "private"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Tier = "public"
  }
}
resource "random_shuffle" "private_subnets" {
  input = tolist(data.aws_subnet_ids.private.ids)
  result_count = 3
}

resource "random_shuffle" "public_subnets" {
  input = tolist(data.aws_subnet_ids.public.ids)
  result_count = 3
}
*/
