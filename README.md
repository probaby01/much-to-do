# MuchToDo - Multi-Tier Kubernetes Deployment

## 🚀 Deployment Instructions
The infrastructure is organized into a modular directory structure.

### 1. Initialize Namespace
```bash
kubectl apply -f kubernetes/namespace.yaml
```

### 2. Deploy Database Layer
```bash
kubectl apply -f kubernetes/mongodb/
```

### 3. Deploy Application Layer
```bash
kubectl apply -f kubernetes/backend/
```

### 4. Deploy Ingress
```bash
kubectl apply -f kubernetes/ingress.yaml
```

## 📊 Current Status
- **Namespace:** muchtodo
- **Database:** MongoDB (Running)
- **Backend:** 2 Replicas (Infrastructure ready / App debugging required)
- **Service Port:** 30080 (NodePort)

## 🛠 Troubleshooting Commands
Check backend logs:
```bash
kubectl logs -l app=backend -n muchtodo
```
