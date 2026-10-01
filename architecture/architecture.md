# Architecture explanation

## Status
This is a hands-on cost-analysis and migration-planning portfolio. No AWS account integration, production migration, deployed EC2/EKS, or measured savings is represented. EKS and EC2/Docker are evaluated as workload-dependent candidates.

## Diagram
The diagram compares two undeployed reference designs and places cost/workload analysis between them. The EKS candidate shows a public ALB, NAT Gateway and bastion alongside private EKS worker capacity and backend AWS services. The EC2/Docker candidate shows Route 53, a multi-AZ public ALB, private application subnets with EC2 Auto Scaling and Docker containers, and backend AWS services. The lower comparison highlights potential areas to evaluate, such as NAT use, rightsizing, Graviton compatibility, image size, logging and storage. These are hypotheses for investigation, not measured outcomes or applied changes.

The center and bottom panels show cost evidence and governance references, including Cost Explorer, Cost Optimization Hub, Compute Optimizer, Budgets, cost allocation tags, S3 lifecycle and CloudWatch retention. The diagram labels the target as a candidate and states that no AWS resources are deployed by default.

The candidate design omits NAT and shows no internet egress from private application subnets. That is suitable only when the workload's dependencies and update paths do not require general egress, or when approved endpoints and controlled paths are designed. It is not a blanket recommendation to remove NAT or expose private workloads.

## Cost drivers
Assess worker/control-plane capacity, ALB/NLB, NAT processing, cross-AZ and internet transfer, EBS/S3, logging/metrics, backup retention, and operations. Use billing dimensions with utilization and workload telemetry. A low average CPU number alone does not justify rightsizing.

## Migration decision
EKS can be appropriate when Kubernetes scheduling, ecosystem, policy, scale, or platform capability is valuable. EC2/Docker can fit a smaller, stable workload when simpler operations offset host patching and orchestration work. Compare total costs, reliability, security, team skill and migration risk; neither option is universally cheaper.

## Network, storage and observability
Measure NAT and transfer paths before considering endpoints or topology changes. Removing NAT requires validating package/image updates and all outbound dependencies; private subnet isolation must remain aligned with security requirements. S3 object lifecycle, EBS sizing and snapshot retention require access and restore evidence. Control log volume and retention without dropping required audit or incident evidence.

## Governance and limitations
Tags, budgets and AWS optimization services are examples and do not imply account configuration. Sample JSON is invented and labeled separately from billing. The Terraform reference is not deployed and omits production hardening. AWS service symbols use the official AWS Architecture Icons package; see architecture/icons/README.md.