provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "gpu-ml-platform"
      Environment = "dev"
      ManagedBy   = "terraform"
      Owner       = var.owner
    }
  }
}

module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = "dev"
  vpc_cidr     = var.vpc_cidr
  azs          = var.azs
}

module "eks" {
  source = "../../modules/eks"

  project_name     = var.project_name
  environment      = "dev"
  cluster_name     = var.cluster_name
  cluster_version  = var.cluster_version
  vpc_id           = module.vpc.vpc_id
  private_subnets  = module.vpc.private_subnets
  public_subnets   = module.vpc.public_subnets

  # CPU node group (default - low cost for learning)
  enable_cpu_nodes = true
  cpu_instance_types = ["t3.medium"]
  cpu_desired_size   = 2
  cpu_min_size       = 1
  cpu_max_size       = 4

  # GPU node group (disabled by default to control costs)
  enable_gpu_nodes   = var.enable_gpu_nodes
  gpu_instance_types = var.gpu_instance_types
  gpu_desired_size   = var.gpu_desired_size
}

# Optional: Monitoring stack can also be installed via Terraform or pure GitOps (recommended)
# module "monitoring" {
#   source = "../../modules/monitoring"
#   cluster_name = module.eks.cluster_name
# }
