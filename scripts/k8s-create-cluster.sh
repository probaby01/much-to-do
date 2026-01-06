#!/bin/bash
set -e

echo "================================"
echo "Creating Kind Cluster"
echo "================================"

# Create cluster config
cat <<EOF > /tmp/kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30080
    hostPort: 8080
    protocol: TCP
EOF

# Create cluster
kind create cluster --name muchtodo-cluster --config /tmp/kind-config.yaml

# Verify
kubectl cluster-info --context kind-muchtodo-cluster

echo ""
echo "✅ Kind cluster created successfully!"
echo ""
