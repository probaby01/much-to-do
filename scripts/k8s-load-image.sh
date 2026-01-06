#!/bin/bash
set -e

echo "================================"
echo "Loading Docker Image to Kind"
echo "================================"

# Load image to Kind cluster
kind load docker-image muchtodo-backend:latest --name muchtodo-cluster

echo ""
echo "✅ Image loaded to Kind cluster!"
echo ""
