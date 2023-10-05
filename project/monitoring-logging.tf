module "eks_monitoring_logging" {
    
    source = "./modules/terraform-aws-eks-monitoring-logging"
    
    cluster_name      = local.name
    aws_region        = local.region
    namespace         = "amazon-cloudwatch"

    enable_cwagent    = true
    enable_fluent_bit = true
    
    # Attach CloudWatchServerPolicy to EKS nodegroup roles
    nodegroup_roles = [
      local.nodegroup_1_role_name,
      local.nodegroup_2_role_name,
    ]

}