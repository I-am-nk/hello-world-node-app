# Kubernetes (EKS) Set up

🧭 EKS — Connect Bastion EC2 to EKS Cluster.

This guide explains how to:
1. Create the IAM Role for the bastion EC2 instance  
2. Launch the Ubuntu EC2 instance in the same VPC and public subnet as your EKS cluster  
3. Connect it to EKS using kubectl and AWS CLI

---

🧱 Architecture Overview

GitHub (source repo)  
      ↓  
Argo CD (GitOps controller on EKS)  
      ↓  
EKS Cluster (running app)  

---

⚙️ Step 1 — Create IAM Role for Bastion EC2 (AWS Console)

We’ll create an IAM role that allows EC2 to access EKS, pull images, and manage networking.

1️⃣ Go to AWS Management Console → IAM → Roles → Create Role  
2️⃣ Select Trusted Entity  
- Choose AWS Service  
- Select EC2  
- Click Next

3️⃣ Attach Policies  
Select and attach the following AWS managed policies:

| Policy                                   | Purpose                                               |
|-----------------------------------------:|:------------------------------------------------------|
| AmazonEKSClusterPolicy                   | Allows EC2 to access EKS API                          |
| AmazonEKSWorkerNodePolicy                | Required for EC2 to communicate with the cluster     |
| AmazonEKS_CNI_Policy                     | Allows pod networking and CNI management              |
| AmazonEC2ContainerRegistryReadOnly       | Allows pulling container images from ECR             |

Click Next → Name the role `eks-bastion-role` → Create Role  
✅ This role gives the Ubuntu EC2 permissions to connect with your EKS cluster.

---

☁️ Step 2 — Launch the Ubuntu EC2 Instance (Bastion Host)

1️⃣ Go to EC2 Console → Launch Instance

- AMI: Ubuntu 22.04 LTS  
- Instance Type: `t3.micro` or `t3.small`  
- Key Pair: Select existing or create new  
- Network Settings:
  - VPC: Select the same VPC as your EKS cluster
  - Subnet: Choose a Public Subnet
  - Auto-assign Public IP: ✅ Enable
- IAM Instance Profile: Select `eks-bastion-role`

Click Launch Instance

---

🔗 Step 3 — Connect to the EC2 via SSH

Use your preferred SSH client (MobaXterm, PuTTY, terminal, etc.) to connect to the instance.

---

⚙️ Step 4 — Install AWS CLI, kubectl, Helm, and Git

Run the following commands on the EC2 instance:

```bash
sudo apt update -y
sudo apt install -y curl unzip git jq

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install

# Install kubectl (latest stable)
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
```

Verify installation:
```bash
aws --version
kubectl version --client --short
```

---

🧩 Step 5 — Connect EC2 to EKS Cluster

Run on the bastion EC2 (adjust cluster name and region as needed):
```bash
aws eks update-kubeconfig --name devops_eks --region ap-south-1
```

Notes:
- In this project `devops_eks` is used as the cluster name and `ap-south-1` as the region — update these values to match your environment.
- ✅ This command automatically creates `/home/ubuntu/.kube/config` and authenticates the EC2 instance using the IAM role.

Verify the connection:
```bash
kubectl get nodes
```

You should see the EKS worker nodes listed — confirming successful access.
