# helm-dragonfly

A Crossplane configuration that deploys Dragonfly via Helm.

Dragonfly is a modern Redis-compatible in-memory datastore that is multi-threaded, memory-efficient, and designed for modern hardware. It's a drop-in replacement for Redis with up to 25x better performance and 80% lower memory usage.

## Quick Start

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Dragonfly
metadata:
  name: dragonfly
  namespace: my-namespace
spec:
  clusterName: my-cluster
```

## Configuration

| Field | Description | Default |
|-------|-------------|---------|
| `clusterName` | Name of the Kubernetes cluster | Required |
| `namespace` | Namespace to deploy Dragonfly | `dragonfly` |
| `releaseName` | Helm release name | XR name |
| `labels` | Labels to apply to resources | See below |
| `values` | Helm values (merged with defaults) | `{}` |
| `overrideAllValues` | Replace all default values | `{}` |
| `providerConfigRef` | Provider config reference | `{name: clusterName, kind: ProviderConfig}` |
| `managementPolicies` | Crossplane management policies | `["*"]` |

### Default Labels

```yaml
hops.ops.com.ai/managed: "true"
hops.ops.com.ai/dragonfly: "<name>"
```

### Default Helm Values

```yaml
replicaCount: 1
```

## Examples

### Minimal

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Dragonfly
metadata:
  name: dragonfly
  namespace: example-env
spec:
  clusterName: example-cluster
```

### Production

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Dragonfly
metadata:
  name: dragonfly
  namespace: example-env
spec:
  clusterName: example-cluster
  namespace: dragonfly
  labels:
    team: platform
    environment: production
  values:
    replicaCount: 3
    resources:
      requests:
        cpu: "1"
        memory: "2Gi"
    persistence:
      enabled: true
      size: 10Gi
```

### Override All Values

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Dragonfly
metadata:
  name: dragonfly
  namespace: example-env
spec:
  clusterName: example-cluster
  overrideAllValues:
    replicaCount: 5
    args:
      - "--maxmemory=4gb"
      - "--proactor_threads=4"
```

## Why Dragonfly?

- **25x faster** than Redis on multi-core machines
- **80% less memory** for the same dataset
- **Drop-in Redis replacement** - works with existing Redis clients
- **Multi-threaded** - utilizes all CPU cores
- **Built-in cluster mode** without Redis Cluster complexity

## Development

```bash
# Build the package
make build

# Render examples
make render

# Validate examples
make validate

# Run unit tests
make test

# Run E2E tests
make e2e
```

## Chart Information

- **Chart**: dragonfly
- **Repository**: oci://ghcr.io/dragonflydb/dragonfly/helm
- **Version**: v1.36.0
