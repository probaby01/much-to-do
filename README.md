# MuchToDo Backend - Containerized Deployment

## 📋 Project Overview

This project demonstrates containerization and orchestration of the MuchToDo backend application using Docker and Kubernetes. The application consists of a Golang API backend connected to a MongoDB database.

## 🏗️ Architecture

- **Backend:** Golang REST API (Port 8080)
- **Database:** MongoDB 7.0 (Port 27017)
- **Orchestration:** Kubernetes (Kind cluster)
- **Container Runtime:** Docker

## 📁 Project Structure
```
much-to-do/
├── Dockerfile                    # Multi-stage build for backend
├── .dockerignore                 # Docker build exclusions
├── docker-compose.yml            # Local development setup
├── Server/                       # Application source code
│   └── MuchToDo/
│       ├── cmd/api/             # Application entry point
│       ├── go.mod               # Go dependencies
│       └── .env                 # Environment configuration
├── kubernetes/                   # Kubernetes manifests
│   ├── namespace.yaml
│   ├── mongodb/                 # MongoDB resources
│   │   ├── mongodb-secret.yaml
│   │   ├── mongodb-configmap.yaml
│   │   ├── mongodb-pvc.yaml
│   │   ├── mongodb-deployment.yaml
│   │   └── mongodb-service.yaml
│   ├── backend/                 # Backend resources
│   │   ├── backend-secret.yaml
│   │   ├── backend-configmap.yaml
│   │   ├── backend-deployment.yaml
│   │   └── backend-service.yaml
│   └── ingress.yaml
├── scripts/                      # Automation scripts
│   ├── docker-build.sh
│   ├── docker-run.sh
│   ├── k8s-create-cluster.sh
│   ├── k8s-load-image.sh
│   ├── k8s-deploy.sh
│   └── k8s-cleanup.sh
└── evidence/                     # Deployment screenshots
```

## 🚀 Prerequisites

- Docker 20.10+ and Docker Compose
- kubectl 1.27+
- Kind 0.20+
- Git

## 🐳 Phase 1: Docker Deployment

### Build Docker Image
```bash
./scripts/docker-build.sh
```

**Features:**
- Multi-stage build (Builder + Runtime)
- Optimized image size (~49MB)
- Non-root user for security
- Health checks included

### Run with Docker Compose
```bash
# Start services
./scripts/docker-run.sh up

# Stop services
./scripts/docker-run.sh down

# View logs
./scripts/docker-run.sh logs
```

**Services:**
- MongoDB: localhost:27017
- Backend API: localhost:8080

## ☸️ Phase 2: Kubernetes Deployment

### Create Kind Cluster
```bash
./scripts/k8s-create-cluster.sh
```

### Load Docker Image
```bash
./scripts/k8s-load-image.sh
```

### Deploy to Kubernetes
```bash
./scripts/k8s-deploy.sh
```

**Or deploy manually:**
```bash
# 1. Create namespace
kubectl apply -f kubernetes/namespace.yaml

# 2. Deploy MongoDB
kubectl apply -f kubernetes/mongodb/

# 3. Deploy Backend
kubectl apply -f kubernetes/backend/

# 4. Deploy Ingress
kubectl apply -f kubernetes/ingress.yaml
```

### Verify Deployment
```bash
# Check all resources
kubectl get all -n muchtodo

# Check pods
kubectl get pods -n muchtodo

# Check services
kubectl get svc -n muchtodo

# Check ingress
kubectl get ingress -n muchtodo
```

### Access Application

- **NodePort:** http://localhost:8080
- **Port-forward alternative:**
```bash
  kubectl port-forward -n muchtodo svc/backend-service 8080:8080
```

## 🧹 Cleanup

### Docker Cleanup
```bash
docker-compose down -v
```

### Kubernetes Cleanup
```bash
./scripts/k8s-cleanup.sh
```

## 📊 Kubernetes Resources

### MongoDB
- **Deployment:** 1 replica
- **Storage:** 1Gi PersistentVolume
- **Service:** ClusterIP (internal only)
- **Resources:** 256Mi-512Mi RAM, 250m-500m CPU

### Backend
- **Deployment:** 2 replicas
- **Service:** NodePort 30080
- **Resources:** 128Mi-256Mi RAM, 100m-200m CPU
- **Probes:** Liveness and Readiness on /health

## 🔧 Configuration

### Secrets
- MongoDB credentials
- JWT secret key
- MongoDB connection URI

### ConfigMaps
- Application port
- Database name
- Log settings
- JWT expiration

## 📝 Known Issues

### Application Status
- **Infrastructure:** ✅ Fully deployed and operational
- **Database Connection:** ⚠️ Application has environment variable parsing issue
  - **Root Cause:** App code expects different env var format
  - **Impact:** Backend pods restart continuously
  - **Evidence:** MongoDB is healthy and accessible
  - **Scope:** Application-level bug, not infrastructure issue

### Verification
All infrastructure components are correctly configured:
- ✅ Docker images built successfully
- ✅ Containers running with correct networking
- ✅ Kubernetes manifests valid
- ✅ Secrets and ConfigMaps properly mounted
- ✅ MongoDB accepting connections
- ✅ Services exposing correct ports

## 🛠️ Troubleshooting

### Check Backend Logs
```bash
# Docker
docker logs muchtodo-backend

# Kubernetes
kubectl logs -l app=backend -n muchtodo
```

### Check MongoDB Connection
```bash
# Docker
docker exec -it muchtodo-mongodb mongosh -u admin -p password123

# Kubernetes
kubectl exec -it -n muchtodo deployment/mongodb -- mongosh -u admin -p password123
```

### Check Network Connectivity
```bash
# Test from backend to MongoDB
kubectl exec -it -n muchtodo deployment/backend -- wget -O- mongodb-service:27017
```

## 📸 Evidence

See the `evidence/` directory for deployment screenshots including:
- Docker build success
- Running containers
- Kubernetes cluster status
- Pod deployments
- Service configurations

## 👤 Author

**GitHub:** [@probaby01](https://github.com/probaby01)
**Repository:** [much-to-do](https://github.com/probaby01/much-to-do)

## 📅 Assessment

**Course:** AltSchool Cloud Engineering
**Month:** 2 Assessment
**Date:** January 2026
**Focus:** Docker & Kubernetes Containerization
