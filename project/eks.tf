module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"
  cluster_name                    = local.name
  cluster_version                 = local.cluster_version
  cluster_enabled_log_types       = ["api", "controllerManager", "scheduler"]
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }

    aws-ebs-csi-driver = {
      most_recent = true
    }

  }
  cluster_tags = {
    Name = local.name
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {

    nodegroup1 = {
      desired_size   = 1
      max_size       = 1
      min_size       = 1
      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
      # Needed by the aws-ebs-csi-driver
      create_iam_role = true
      iam_role_use_name_prefix = false
      iam_role_name = local.nodegroup_1_role_name
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
      labels = {
        role = local.nodegroup1_label
        team = local.team1
        project = local.project1
        workload = "medium"
      }

      tags = local.tags
    }
    

    nodegroup2 = {
      desired_size   = 1
      max_size       = 1
      min_size       = 1
      instance_types = ["t3.small"]
      capacity_type  = "ON_DEMAND"
      # Needed by the aws-ebs-csi-driver
      create_iam_role = true
      iam_role_use_name_prefix = false
      iam_role_name = local.nodegroup_2_role_name
      iam_role_additional_policies = {
        AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
        AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
      labels = {
        role = local.nodegroup2_label
        team = local.team2
        project = local.project2
        workload = "small"
      }
      taints = [
        {
          key    = "dedicated"
          value  = local.nodegroup2_label
          effect = "NO_SCHEDULE"
        }
      ]
      tags = local.tags
      
    }
  }

  tags = local.tags
}