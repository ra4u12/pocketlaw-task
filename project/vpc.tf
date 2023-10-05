module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name = local.name
  cidr = local.vpc_cidr

  azs             = local.azs
  private_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 4, k)]
  public_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 48)]

  enable_nat_gateway     = true
  enable_dns_hostnames = true
  single_nat_gateway     = true
  create_egress_only_igw = true
  public_subnet_tags = {
    "kubernetes.io/role/elb" : 1
  }

  tags = local.tags
}


