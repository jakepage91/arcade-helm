# Arcade Helm Chart

This Helm chart deploys the Arcade AI Engine and Worker in a Kubernetes cluster.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `arcade`:

```bash
helm install arcade ./arcade-helm
```

### Installing in Minikube

If you're using Minikube, follow these steps:

1. Start Minikube:
   ```bash
   minikube start
   ```

2. Install the Helm chart:
   ```bash
   helm install arcade .
   ```

3. Wait for all pods to be ready:
   ```bash
   kubectl get pods -w
   ```

4. Access the Arcade Engine API:
   ```bash
   kubectl port-forward svc/arcade-engine 9099:9099
   ```

5. Visit http://localhost:9099 in your browser

## Configuration

The following table lists the configurable parameters of the Arcade chart and their default values.

### Engine Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `engine.image.repository` | Engine image repository | `ghcr.io/arcadeai/engine` |
| `engine.image.tag` | Engine image tag | `latest` |
| `engine.image.pullPolicy` | Engine image pull policy | `IfNotPresent` |
| `engine.service.type` | Engine service type | `ClusterIP` |
| `engine.service.port` | Engine service port | `9099` |
| `engine.resources` | Engine resource requests/limits | See `values.yaml` |
| `engine.environment` | Engine environment variables | See `values.yaml` |

### Worker Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `worker.enabled` | Enable worker | `true` |
| `worker.build.enabled` | Build worker image | `true` |
| `worker.build.context` | Worker build context | `.` |
| `worker.build.dockerfile` | Worker Dockerfile | `Dockerfile.worker` |
| `worker.image.repository` | Worker image repository | `arcade-worker` |
| `worker.image.tag` | Worker image tag | `latest` |
| `worker.image.pullPolicy` | Worker image pull policy | `IfNotPresent` |
| `worker.service.type` | Worker service type | `ClusterIP` |
| `worker.service.port` | Worker service port | `8002` |
| `worker.resources` | Worker resource requests/limits | See `values.yaml` |
| `worker.environment` | Worker environment variables | See `values.yaml` |

### PostgreSQL Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `postgres.enabled` | Enable PostgreSQL | `true` |
| `postgres.image.repository` | PostgreSQL image repository | `postgres` |
| `postgres.image.tag` | PostgreSQL image tag | `15` |
| `postgres.image.pullPolicy` | PostgreSQL image pull policy | `IfNotPresent` |
| `postgres.service.type` | PostgreSQL service type | `ClusterIP` |
| `postgres.service.port` | PostgreSQL service port | `5432` |
| `postgres.resources` | PostgreSQL resource requests/limits | See `values.yaml` |
| `postgres.environment` | PostgreSQL environment variables | See `values.yaml` |
| `postgres.persistence.enabled` | Enable PostgreSQL persistence | `true` |
| `postgres.persistence.size` | PostgreSQL persistence size | `1Gi` |
| `postgres.persistence.storageClass` | PostgreSQL persistence storage class | `""` |

### Redis Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `redis.enabled` | Enable Redis | `true` |
| `redis.image.repository` | Redis image repository | `redis` |
| `redis.image.tag` | Redis image tag | `7` |
| `redis.image.pullPolicy` | Redis image pull policy | `IfNotPresent` |
| `redis.service.type` | Redis service type | `ClusterIP` |
| `redis.service.port` | Redis service port | `6379` |
| `redis.resources` | Redis resource requests/limits | See `values.yaml` |
| `redis.command` | Redis command | See `values.yaml` |
| `redis.persistence.enabled` | Enable Redis persistence | `true` |
| `redis.persistence.size` | Redis persistence size | `1Gi` |
| `redis.persistence.storageClass` | Redis persistence storage class | `""` |

## Troubleshooting

If you encounter issues with the deployment, check the logs of the pods:

```bash
kubectl logs -f deployment/arcade-engine
kubectl logs -f deployment/arcade-worker
kubectl logs -f deployment/arcade-postgres
kubectl logs -f deployment/arcade-redis
```

## Uninstalling the Chart

To uninstall/delete the `arcade` deployment:

```bash
helm delete arcade
``` 