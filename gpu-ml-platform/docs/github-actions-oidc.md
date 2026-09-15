# GitHub Actions ↔ AWS OIDC Setup

This project uses **OpenID Connect (OIDC)** so GitHub Actions can assume an AWS IAM role without storing long-lived access keys.

## Steps

### 1. Create the OIDC Identity Provider in AWS (one-time)

```bash
aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 6938fd4d98bab03faadb97b34396831e3780aea1
```

### 2. Create an IAM Role

Trust policy example (replace `YOUR_GH_ORG` and `YOUR_REPO`):

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::ACCOUNT_ID:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        },
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:YOUR_GH_ORG/gpu-ml-platform:*"
        }
      }
    }
  ]
}
```

Attach a policy that allows the necessary Terraform + Cost Explorer actions (or start with `AdministratorAccess` for learning, then tighten).

### 3. Add the Role ARN as a GitHub Secret

In your GitHub repository:

Settings → Secrets and variables → Actions → New repository secret

- Name: `AWS_ROLE_ARN`
- Value: `arn:aws:iam::ACCOUNT_ID:role/github-actions-gpu-ml-platform`

### 4. (Optional) Protect the `production` environment

Settings → Environments → New environment → `production`  
Add required reviewers if you want manual approval before `terraform apply`.

---

Once this is done, the workflows in `.github/workflows/` will be able to authenticate securely.
