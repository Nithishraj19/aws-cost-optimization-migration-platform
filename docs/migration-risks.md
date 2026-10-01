# Migration risks

| Risk | Detection and mitigation | Rollback and monitoring |
|---|---|---|
| Rightsizing harms performance | Peak CPU, memory, I/O, latency; load test and retain headroom | Restore size; watch SLO/saturation |
| ARM64 incompatible | Test native dependencies and base images | Keep amd64 path; compare errors |
| Workload depends on Kubernetes | Inventory operators, CSI, service mesh, APIs | Stop migration; retain cluster |
| NAT removal breaks egress | Flow logs and dependency tests; assess endpoints | Restore controlled egress; alert failures |
| Cross-AZ transfer increases | Attribute paths and traffic | Revert topology; track availability/transfer |
| Log tuning hides evidence | Review audit/security needs | Restore retention; monitor coverage |
| Lifecycle harms S3 retrieval | Test access and restore | Restore class/data; monitor latency |
| Cost change harms availability | Check SLO and failover | Revert and observe recovery |
| Rollback fails | Canary health and dependency tests | Keep known-good artifact and data plan |

Design scenarios only; no production incidents are claimed.
