# Service selection and cost trade-offs

## Network
NAT Gateway has hourly and processing charges; measure destination, bytes and AZ path. VPC endpoints may be better for eligible AWS service traffic but have their own price and operational/security implications. ALB provides HTTP-aware rules and health checks; NLB serves layer 4/static IP patterns. Route 53 hosted zones, queries and health checks have their own charges. Cross-AZ and internet transfer depend on topology and volume. Never trade away required isolation or AZ resilience solely to reduce traffic charges.

## Compute and containers
EKS includes control-plane, worker capacity, networking, add-ons and operational effort. EC2/Docker trades cluster capabilities for host patching, scheduling, deployment and recovery ownership. Lambda can fit event-driven, bursty tasks but includes invocation/duration, limits, cold start and redesign considerations. Graviton may improve price/performance for compatible workloads, but compatibility and measured performance are prerequisites.

## Storage and observability
EBS block storage, snapshots and provisioned performance are different from S3 object storage and lifecycle classes. CloudWatch charges can include ingestion, retention, metrics, alarms, dashboards and queries. External observability adds vendor/licensing and possible ingestion/egress costs. Choose by recovery needs, audit requirements, operational capabilities and measured usage; don't remove useful evidence blindly.

## Managed services and messaging
RDS can reduce database host administration but introduces managed-service pricing, engine/version constraints and failover/backup configuration. Self-managed databases require patching, HA and recovery operations. SQS provides managed queue semantics; Kafka provides event-stream retention/replay and throughput control with greater platform responsibility unless managed. Select by delivery/ordering/replay requirements, latency, operations, failure model and total cost.

An example S3 lifecycle is hot objects in Standard, infrequently accessed objects in an appropriate IA class, and long-retention data in an archive class. Validate object size, minimum storage duration, retrieval delay/fees, legal retention and restore procedures before enabling transitions.
