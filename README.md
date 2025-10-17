# End-to-End DevOps Project on AWS with CI/CD Pipeline

This is a simple Node.js web application that responds with "Hello World" when accessed.

# Project Overview 
- In this project, we use Amazon Web Services (AWS) as our cloud provider to deploy a containerized application in a scalable and automated environment.

- We leverage Terraform to implement Infrastructure as Code (IaC) for provisioning AWS resources such as the VPC, EKS cluster, and S3 backend for state management.

- The application is deployed on Amazon EKS (Elastic Kubernetes Service) using Kubernetes Deployment and Service resources to achieve features like auto-healing, scalability, and internet connectivity through a load balancer.

- For continuous deployment, we integrate Argo CD, which automatically synchronizes and deploys the latest changes from the source code repository to the EKS cluster. This ensures seamless, zero-downtime deployments and maintains the desired state of the application in production.
---

## Project Architecture


![ad](https://github.com/user-attachments/assets/d9ebdf6c-b54d-4262-b198-4f30dead711a)


---
## Project Structure
```
hello-world-node-app/
├── .github/
│   └── workflows/                  # (GitHub Actions workflow files)
│
├── Kubernetes/                     # (K8s manifests for ArgoCD deployments)
│   ├── deployment.yaml
│   └── service.yaml
│
├── src/
│   └── app.js                      # (Node.js application source)
│
├── Terraform/                      # (Infrastructure as Code)
│   ├── Backend/                    # (Terraform backend configuration)
│   │   └── s3_backend.tf           # (S3 backend config for state storage)
│   │
│   ├── Modules/                    # (Reusable modules)
│   │   ├── EKS/                    # (EKS cluster setup)
│   │   └── VPC/                    # (VPC networking setup)
│   │
│   ├── main.tf                     # (Main Terraform configuration)
│   ├── output.tf                   # (Outputs for VPC, EKS, etc.)
│   └── variable.tf                 # (Input variables)
│
├── Dockerfile                      # (Build instructions for Node.js app)
├── package.json                    # (App dependencies and scripts)
└── README.md                       # (Optional — add documentation)
```

## 🧱 Project Components
👉 Note:  follow the readme.md file of each components to run the project.

### 🚀 Terraform (Infrastructure as Code)
Automates provisioning of:  
- VPC, subnets, internet gateway  
- EKS Cluster  
- S3 bucket for state management

📄 [Terraform README → ](https://github.com/I-am-nk/hello-world-node-app/tree/master/Terraform#readme)

---
### 🐳 Docker set up
- Runs the project locally 
- Helps test the application before deploying.

📄 [Docker README →](https://github.com/I-am-nk/hello-world-node-app/blob/master/Docker%20set%20up/readme.md)

---
### ☸️ Kubernetes (Container Orchestration)
- Deployments, Services and LoadBalancer services.  
- Ec2 as a bastion host connecting to EKS setup.  
- Manifests are automatically updated by GitHub Actions.

📄 [Kubernetes README →](https://github.com/I-am-nk/hello-world-node-app/tree/master/Kubernetes#readme)
 
  
  ---
### 🚀 ArgoCD (GitOps Continuous Deployment)
- Auto-syncs Kubernetes manifests from GitHub.  
- Deploys the app to the EKS cluster continuously.  

📄 [ArgoCD README →](https://github.com/I-am-nk/hello-world-node-app/tree/master/ArgoCD#readme)

---
### 🛠️ GitHub Actions (CI/CD)
Defines the pipeline with:  
- Code checkout  
- Build & push Docker images  
- Kubernetes manifest updates

📄 [Github Actions README →](https://github.com/I-am-nk/hello-world-node-app/blob/master/Github%20Action%20Readme.md)

---

## 👨‍💻 Author
**Nandkishor Khandare**  
Cloud & DevOps / SRE Engineer  

## 📬 **Contact**: 
[LinkedIn](https://www.linkedin.com/in/nandkishor-khandare-616492215/) | [Email](nandkishor.k6e@gmail.com)
