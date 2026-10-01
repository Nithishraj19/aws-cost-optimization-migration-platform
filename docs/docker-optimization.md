# Docker image and ARM64 exercise

The before example uses the full Node 22 base and copies the application into it. The optimized example uses node:22-alpine and runs as the built-in non-root node user. This is a demonstration pair, not a controlled experiment: base distribution, included tools and image content differ, so any observed size delta cannot be attributed to one change alone.

Measure locally after a successful build using docker image ls or docker image inspect. Record host architecture, Docker version, image digest, build command and measurement date. Build time was not measured for this run.

For multi-platform output, buildx targets linux/amd64 and linux/arm64 and writes an OCI archive. Check every native dependency and run tests on each target platform. A successful cross-build alone does not establish runtime correctness or a production Graviton migration.

## Local measurements (October 1, 2026)

Built on the local Apple Silicon Docker host with Docker Engine 29.7.2. The two images were built from the repository root. Docker image inspect Size reported:

| Image | Docker image inspect Size (layer size) | Runtime check |
|---|---:|---|
| cost-demo:before (node:22) | 399,790,089 bytes (~381.3 MiB) | Built successfully |
| cost-demo:optimized (node:22-alpine) | 61,063,796 bytes (~58.2 MiB) | Built; /health and /version returned success on linux/arm64 |

These values are local image metadata for this build, not registry transfer measurements or cost savings. The examples use different base distributions, so this is not a controlled optimization comparison and the delta must not be attributed solely to the Dockerfile techniques. Rebuild on your own host to reproduce; image tags and upstream base layers change.

The optimized Dockerfile also built for linux/amd64 and linux/arm64 using Buildx and exported a multi-platform OCI archive successfully. The app was executed locally on arm64; the amd64 variant was cross-built but not separately run. No Graviton or AWS test was performed.

Reproduce the size check with:

    docker image inspect --format '{{.RepoTags}} {{.Size}} bytes' cost-demo:before cost-demo:optimized
