#!/bin/bash
set -e

echo "================================"
echo "Cleaning up Kubernetes Resources"
echo "================================"

# Delete all resources in namespace
kubectl delete namespace muchtodo --ignore-not-found=true

# Delete Kind cluster
kind delete cluster --name muchtodo-cluster

echo ""
echo "✅ Cleanup complete!"
echo ""
