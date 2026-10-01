# Interview guide

**How identify cost drivers?** Reconcile billing dimensions and tags with inventory and telemetry; split fixed/shared from variable spend.

**How rightsize?** Review representative peaks, CPU, memory, I/O, network, queues and seasonality. Test under load and define rollback. Never use average CPU alone.

**EKS or EC2/Docker?** Compare platform, capacity, density, network, scaling, reliability and toil. EKS suits Kubernetes needs and platform maturity; EC2/Docker may fit smaller stable workloads with host operations. No universal winner.

**When not migrate?** Kubernetes dependencies, operators, policy, scaling needs, or migration/host operations risks can outweigh modeled benefit.

**Graviton?** Build/test ARM64, check native dependencies, benchmark representative load and pilot with rollback. No production ARM migration is claimed.

**NAT, transfer, ALB/NLB?** Attribute bytes/hours and traffic paths; choose alternatives while retaining security and AZ resilience.

**Logs, S3, EBS?** Ingestion, retention, cardinality and queries drive observability spend. Lifecycle needs restore evidence. S3 object and EBS block storage differ.

**Governance?** Tags, Cost Explorer, Budgets, Compute Optimizer and Cost Optimization Hub support review when configured; there is no AWS account integration here.

**How prove savings?** Compare normalized measured bills after a controlled pilot including migration, toil and reliability. No actual bill or savings is claimed in this project.
