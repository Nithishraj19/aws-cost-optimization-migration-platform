# EKS versus EC2 and Docker

| Area | EKS candidate | EC2 + Docker candidate |
|---|---|---|
| Compute | Worker capacity plus control plane; scheduling density matters | Instance capacity and headroom; host lifecycle is owned |
| Network | CNI, load balancers, NAT, transfer and storage paths | VPC, ALB, host networking, egress and transfer |
| Scaling | Pod/node autoscaling and Kubernetes scheduling | ASG scaling; container placement needs design |
| Operations | Upgrades, add-ons, policy and cluster incidents | AMIs, patching, deployment orchestration and host incidents |
| Cost | Control plane, nodes, networking, logs and toil | EC2, ALB, networking, storage, logs and toil |

EKS fits many services, Kubernetes APIs/ecosystem or mature platform teams. EC2/Docker may fit smaller stable services with host operations capability. Neither is always cheaper. Include workload, availability, security, performance and engineering effort. EC2 vs Lambda, SQS vs Kafka, S3 vs EBS, ALB vs NLB and managed vs self-managed are workload-dependent.
