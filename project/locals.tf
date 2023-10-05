locals {
  name             = "eks-task2"
  cluster_version  = "1.26"
  region           = "us-east-2"
  nodegroup1_label = "group1"
  nodegroup2_label = "group2"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)
  team1 = "application_team"
  team2 = "datascience_team"
  project1 = "internal"
  project2 = "external"
  nodegroup_1_role_name = "nodegroup_1_iam_role"
  nodegroup_2_role_name = "nodegroup_2_iam_role"

  vpc_cidr = "10.11.0.0/16"

  tags = {
    Owner = "terraform"
    environment = "test"
    task = "task2"
  }
}

data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}