# Architecture Overview

## High-Level Design

This platform follows modern cloud-native and GitOps principles:

1. **Infrastructure Layer (Terraform)**
   - VPC with public/private subnets across multiple AZs
   - EKS cluster with managed node groups
   - Separate CPU and GPU node groups (GPU disabled by default)
   - IRSA-ready (OIDC provider)

2. **GitOps Layer (ArgoCD)**
   - App-of-Apps pattern (`argocd/bootstrap/root-app.yaml`)
   - Declarative management of platform components and ML workloads
   - Automated sync + self-heal

3. **CI/CD Layer (GitHub Actions)**
   - Terraform plan on every PR (with PR comment)
   - Terraform apply on merge to main (protected environment)
   - OIDC authentication (no long-lived AWS keys)
   - Scheduled FinOps reporting
   - Manifest validation

4. **Workload Layer**
   - Standardized Kubernetes Jobs for training
   - Deployments + Services for model serving
   - Ready for GPU scheduling (taints/tolerations/nodeSelectors)

5. **Observability & FinOps**
   - Prometheus/Grafana via GitOps (observability/)
   - Daily cost reports posted as GitHub Issues
   - Scripts for idle resource detection (extensible)

## Design Decisions

- **CPU-first default**: Keeps learning costs near zero. GPU is one flag away.
- **OIDC over access keys**: Security best practice for GitHub Actions → AWS.
- **App-of-Apps**: Scales cleanly when you add more components later.
- **Modular Terraform**: Easy to reuse VPC/EKS modules in other projects.
- **FinOps from day one**: Cost visibility is treated as a first-class concern.

## Future Extensions (easy to add)

- NVIDIA GPU Operator via ArgoCD
- KServe or Triton for advanced model serving
- Kubeflow / Ray for distributed training
- Crossplane or Terraform Controllers
- Multi-cluster / multi-environment promotion
