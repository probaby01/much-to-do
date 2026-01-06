#!/bin/bash
set -e

echo "================================"
echo "Deploying to Kubernetes"
echo "================================"

# Apply namespace first
echo "Creating namespace..."
kubectl apply -f kubernetes/namespace.yaml

# Deploy MongoDB
echo "Deploying MongoDB..."
kubectl apply -f kubernetes/mongodb/

# Wait for MongoDB to be ready
echo "Waiting for MongoDB to be ready..."
kubectl wait --for=condition=ready pod -l app=mongodb -n muchtodo --timeout=120s

# Deploy Backend
echo "Deploying Backend..."
kubectl apply -f kubernetes/backend/

# Deploy Ingress
echo "Deploying Ingress..."
kubectl apply -f kubernetes/ingress.yaml

echo ""
echo "✅ Deployment complete!"
echo ""
echo "Checking status..."
kubectl get all -n muchtodo

echo ""
echo "Backend accessible at: http://localhost:8080"
echo ""
