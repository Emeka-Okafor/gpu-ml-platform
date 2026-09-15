# Cost Optimization & FinOps Practices

This project treats cost management as a core engineering concern (FinOps).

## Strategies Demonstrated

1. **Default to low-cost resources**
   - CPU node groups only by default
   - GPU node groups are opt-in (`enable_gpu_nodes = false`)

2. **Strong tagging**
   - Every resource is tagged with Project, Environment, ManagedBy, Owner
   - Enables accurate cost allocation and showback

3. **Automated visibility**
   - Daily GitHub Actions workflow runs `cost_report.py`
   - Results are posted as GitHub Issues for easy tracking

4. **Right-sizing guidance**
   - Start with `t3.medium` / `g4dn.xlarge`
   - Use cluster autoscaler / Karpenter in real production

5. **Cleanup culture**
   - Clear instructions to run `terraform destroy`
   - Idle resource detection scripts can be extended

## Recommended Production FinOps Add-ons

- AWS Budgets + anomaly detection
- Kubecost or OpenCost for Kubernetes-native cost allocation
- Spot / Graviton / Savings Plans for non-GPU workloads
- Automated shutdown of dev clusters outside business hours
- Chargeback reports per team / ML experiment

## Important Warning

GPU instances (even g4dn.xlarge) can become expensive quickly if left running.  
Always destroy the stack when you are not actively using it.
