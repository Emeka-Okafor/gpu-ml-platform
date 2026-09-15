variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "enable_cpu_nodes" {
  type    = bool
  default = true
}

variable "cpu_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "cpu_desired_size" {
  type    = number
  default = 2
}

variable "cpu_min_size" {
  type    = number
  default = 1
}

variable "cpu_max_size" {
  type    = number
  default = 4
}

variable "enable_gpu_nodes" {
  type    = bool
  default = false
}

variable "gpu_instance_types" {
  type    = list(string)
  default = ["g4dn.xlarge"]
}

variable "gpu_desired_size" {
  type    = number
  default = 0
}
