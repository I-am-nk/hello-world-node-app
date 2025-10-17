# ⚙️ GitHub Actions CI Workflow — Build, Push, and Trigger Argo CD Deployment

## 🧠 Workflow Overview
**Trigger:**  
Whenever a change is pushed to the `master` branch, GitHub Actions runs the CI workflow.

**Actions performed:**
1. Checkout the latest code.  
2. Log in to Docker Hub using stored secrets.  
3. Build a Docker image with a unique tag (based on the commit SHA).  
4. Push the image to your Docker Hub repository.  
5. Update the Kubernetes deployment manifest with the new image tag.  
6. Commit and push the updated manifest back to the repo.  
7. Argo CD detects the change → syncs → deploys the new version automatically to EKS.

---

## 🧾 Workflow File Path
`.github/workflows/Complete-CICD.yml`

---

## 🔐 Required GitHub Secrets

| Secret Name        | Description                                          | Example                                                                 |
|--------------------|------------------------------------------------------|-------------------------------------------------------------------------|
| DOCKERHUB_USERNAME | Your Docker Hub username                             | `username`                                                              |
| DOCKERHUB_TOKEN    | Docker Hub access token with read/write access       | (from Docker Hub → Account Settings → Security → Access Tokens)         |


> You do **not** need to store kubeconfig or AWS credentials in GitHub Actions because:
> - Argo CD handles deployment inside the cluster (GitOps model).  
> - GitHub Actions is responsible only for CI (build + push + manifest update).

---

## 🧾 Summary (Steps)
| Step | Description |
|------|-------------|
| 1️⃣ | Developer pushes code to GitHub |
| 2️⃣ | Workflow builds new Docker image and pushes to Docker Hub |
| 3️⃣ | Workflow updates the image reference in `deployment.yaml` |
| 4️⃣ | Workflow commits manifest to GitHub |
| 5️⃣ | Argo CD syncs automatically and redeploys new version |

---

## 🚀 End-to-End Flow Diagram
```
┌───────────────┐
│ Developer     │
│ pushes code   │
└──────┬────────┘
       │
       ▼
┌───────────────┐
│ GitHub Action │
│ Build & Push  │
│ Docker Image  │
└──────┬────────┘
       │
       ▼
┌───────────────┐
│ GitHub Repo   │
│ Updated YAML  │
└──────┬────────┘
       │
       ▼
┌───────────────┐
│ Argo CD       │
│ Auto Sync     │
│ Deploy to EKS │
└───────────────┘
```

---

## 🧠 Summary of Why This Approach is Best

| Feature     | Benefit                                                       |
|-------------|---------------------------------------------------------------|
| GitOps-based | Argo CD continuously ensures the cluster matches Git state   |
| Secure      | No kubeconfig or AWS credentials in GitHub Actions            |
| Automated   | Full CI/CD from commit → deploy                               |
| Traceable   | Every deployment version corresponds to a Git commit          |
| Portable    | Works with any Kubernetes cluster (EKS, GKE, AKS, Minikube)   |

---
