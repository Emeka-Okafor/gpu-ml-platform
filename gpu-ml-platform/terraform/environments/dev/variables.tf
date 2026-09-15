variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name used for tagging and resource naming"
  type        = string
  default     = "gpu-ml-platform"
}

variable "owner" {
  description = "Owner tag (your name or team)"
  type        = string
  default     = "portfolio"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "gpu-ml-platform-dev"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "enable_gpu_nodes" {
  description = "Whether to create GPU node groups (WARNING: costs money)"
  type        = bool
  default     = false
}

variable "gpu_instance_types" {
  description = "Instance types for GPU nodes"
  type        = list(string)
  default     = ["g4dn.xlarge"]  # Cheapest NVIDIA T4 option
}

variable "gpu_desired_size" {
  description = "Desired number of GPU nodes"
  type        = number
  default     = 0
}
