# Migration plan

No AWS migration has occurred. Assess inventory, dependencies, billing dimensions, telemetry, objectives and operating toil. Design workload-specific alternatives and record assumptions. Build images and host lifecycle. Test compatibility, performance, recovery and ARM64. Pilot a low-risk service with canary traffic, stop/go SLOs and the old path preserved. Migrate only with approval and rollback ready. Monitor SLOs and comparable billing; normalize traffic and one-time costs before claiming savings. Retain EKS where platform capabilities or migration risk justify it.
