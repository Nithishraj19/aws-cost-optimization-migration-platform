# Architecture explanation

## Status
This is a hands-on cost-analysis and migration-planning portfolio. No AWS account integration, production migration, deployed EC2/EKS, or measured savings is represented. EKS and EC2/Docker are evaluated as workload-dependent candidates.

## Diagram
The orange cost-evidence band represents Cost Explorer, Cost Optimization Hub, Budgets/tags, and Compute Optimizer as reference services. The left dashed-comparison concept is an EKS cost/operations candidate. The right green design is an EC2 Auto Scaling and Docker optimized candidate within a Region/VPC/AZ network shape. It is a reference design, not an installed environment. S3 lifecycle and CloudWatch retention are cost lenses.

## Cost drivers
Assess worker/control-plane capacity, ALB/NLB, NAT processing, cross-AZ and internet transfer, EBS/S3, logging/metrics, backup retention, and operations. Use billing dimensions with utilization and workload telemetry. A low average CPU number alone does not justify rightsizing.

## Migration decision
EKS can be appropriate when Kubernetes scheduling, ecosystem, policy, scale, or platform capability is valuable. EC2/Docker can fit a smaller, stable workload when simpler operations offset host patching and orchestration work. Compare total costs, reliability, security, team skill and migration risk; neither option is universally cheaper.

## Network, storage and observability
Measure NAT and transfer paths before considering endpoints or topology changes. Do not weaken private networking to cut spend. S3 object lifecycle, EBS sizing and snapshot retention require access and restore evidence. Control log volume and retention without dropping required audit or incident evidence.

## Governance and limitations
Tags, budgets and AWS optimization services are examples and do not imply account configuration. Sample JSON is invented and labeled separately from billing. The Terraform reference is not deployed and omits production hardening. AWS service symbols use the official AWS Architecture Icons package; see architecture/icons/README.md.