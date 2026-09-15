module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = merge(
    var.enable_cpu_nodes ? {
      cpu = {
        name           = "cpu-nodes"
        instance_types = var.cpu_instance_types
        desired_size   = var.cpu_desired_size
        min_size       = var.cpu_min_size
        max_size       = var.cpu_max_size

        labels = {
          workload-type = "general"
        }
      }
    } : {},

    var.enable_gpu_nodes ? {
      gpu = {
        name           = "gpu-nodes"
        instance_types = var.gpu_instance_types
        desired_size   = var.gpu_desired_size
        min_size       = 0
        max_size       = 3

        labels = {
          workload-type = "gpu"
          "nvidia.com/gpu" = "true"
        }

        taints = [
          {
            key    = "nvidia.com/gpu"
            value  = "true"
            effect = "NO_SCHEDULE"
          }
        ]
      }
    } : {}
  )

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}
