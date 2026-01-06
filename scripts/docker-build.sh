#!/bin/bash
set -e
echo "================================"
echo "Building Docker Image"
echo "================================"
docker build -t muchtodo-backend:latest .
if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build Successful!"
    echo ""
    docker images muchtodo-backend
else
    echo "❌ Build Failed!"
    exit 1
fi
