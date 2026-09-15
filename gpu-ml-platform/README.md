# GPU-Optimized ML Platform on Kubernetes (GitOps + FinOps)

> **Portfolio Project** — Production-style cloud infrastructure for ML training & serving, built entirely with Infrastructure-as-Code, GitOps, and GitHub Actions.

![Terraform](https://img.shields.io/badge/IaC-Terraform-7B42BC?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-326CE5?logo=kubernetes)
![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-EF7B4D?logo=argo)
![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions)
![AWS](https://img.shields.io/badge/Cloud-AWS%20EKS-FF9900?logo=amazon-aws)

---

## Project Overview

This repository demonstrates the end-to-end design and implementation of a **production-ready ML platform** on Kubernetes, optimized for GPU workloads. It covers the full lifecycle of modern cloud infrastructure:

- Designing and implementing cloud infrastructure from the ground up
- Building and maintaining Kubernetes clusters optimized for GPU/ML workloads and SaaS hosting
- Implementing GitOps practices using ArgoCD for continuous deployment
- Developing Infrastructure as Code using Terraform
- Creating and maintaining CI/CD pipelines (GitHub Actions) for infrastructure and application deployment
- Implementing monitoring and observability solutions for distributed systems
- Automating infrastructure management with Python and Bash
- Collaboration patterns with ML engineers (standardized training jobs & model serving)
- Implementing and maintaining cost optimization strategies (FinOps), especially for GPU-intensive workloads

### Architecture Highlights

```
GitHub Repo (this repo)
    │
    ├── GitHub Actions (CI/CD + FinOps schedules)
    │       │
    │       ├── Terraform Plan/Apply (OIDC → AWS)
    │       ├── Image Build & Push
    │       └── Cost Reports / Idle Cleanup
    │
    ▼
AWS (EKS Cluster)
    │
    ├── GPU Node Groups (or CPU fallback)
    ├── ArgoCD (GitOps engine)
    ├── kube-prometheus-stack (Observability)
    ├── Sample PyTorch Training Job
    └── Model Serving example
```

---

## Repository Structure

```
gpu-ml-platform/
├── terraform/                  # Infrastructure as Code
│   ├── environments/dev/       # Environment-specific config
│   └── modules/                # Reusable modules (VPC, EKS, GPU nodes, Monitoring)
├── argocd/                     # GitOps manifests (App-of-Apps pattern)
├── workloads/                  # Sample ML training & serving manifests
├── observability/              # Prometheus/Grafana values & dashboards
├── automation/                 # Python + Bash FinOps & helper scripts
├── .github/workflows/          # GitHub Actions CI/CD + scheduled jobs
└── docs/                       # Architecture, cost notes, runbooks
```

---

## Prerequisites

- AWS Account (Free Tier eligible for learning; GPU nodes cost extra)
- GitHub repository (this project)
- `terraform` >= 1.5
- `kubectl`, `helm`, `aws` CLI
- (Optional) `kind` for local testing

---

## Quick Start

### 1. Fork / Clone this repository

```bash
git clone https://github.com/<your-username>/gpu-ml-platform.git
cd gpu-ml-platform
```

### 2. Configure AWS credentials for local development

```bash
aws configure
# or use AWS SSO / environment variables
```

### 3. Bootstrap the infrastructure (Dev environment)

```bash
cd terraform/environments/dev
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values (region, cluster name, etc.)

terraform init
terraform plan
terraform apply
```

### 4. Configure kubectl

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

### 5. Install ArgoCD (one-time bootstrap)

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
# Then apply the App-of-Apps
kubectl apply -f argocd/bootstrap/root-app.yaml
```

### 6. Set up GitHub Actions (OIDC – recommended, no long-lived keys)

Follow the instructions in `docs/github-actions-oidc.md` to configure OIDC between GitHub and AWS.

---

## GitHub Actions Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `terraform.yml` | Pull Request + Push to main | `terraform plan` on PRs, `apply` on main (with environment protection) |
| `workloads.yml` | Changes in workloads/ or Dockerfile | Build & push container images |
| `finops.yml` | Schedule (daily) + manual | Cost report + idle resource detection |

All workflows use **OIDC** for secure, short-lived AWS credentials.

---

## Key Features Demonstrated

- **Infrastructure as Code** — Fully modular Terraform (VPC, EKS, node groups, IRSA, etc.)
- **GitOps** — ArgoCD App-of-Apps pattern for platform + workloads
- **CI/CD** — GitHub Actions with plan/apply separation, security scanning, and image pipelines
- **GPU Readiness** — Node groups, taints/tolerations, NVIDIA GPU Operator ready
- **Observability** — Prometheus + Grafana stack via GitOps
- **FinOps** — Automated tagging, cost reporting scripts, idle cleanup helpers
- **ML Collaboration** — Standardized Job/Deployment examples for training and serving

---

## Cost Notes (Important)

- Default configuration uses **CPU nodes only** so you can learn without high GPU costs.
- GPU node groups are included but commented / disabled by default.
- Always destroy resources when not in use: `terraform destroy`
- See `docs/cost-optimization.md` for FinOps strategies demonstrated in this project.

---

## Documentation

- [Architecture Overview](docs/architecture.md)
- [Cost Optimization & FinOps](docs/cost-optimization.md)
- [GitHub Actions + OIDC Setup](docs/github-actions-oidc.md)
- [Runbooks](docs/runbooks.md)

---

## What This Project Shows Recruiters / Hiring Managers

This is not a toy example. It demonstrates the ability to:

1. Own cloud infrastructure end-to-end
2. Apply production GitOps practices
3. Build secure CI/CD with modern authentication (OIDC)
4. Think about cost from day one (FinOps)
5. Create patterns that ML engineers can actually use
6. Write clean, modular, documented Infrastructure as Code

---

## License

MIT — feel free to use this as a starting point for your own portfolio or real projects.

---

**Built as a portfolio project to demonstrate modern cloud + ML platform engineering skills.**
