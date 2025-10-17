# 🧱 Terraform Infrastructure Setup (AWS EKS + VPC)

## 🏗️ Project Structure (Terraform Folder)

```
Terraform/
├── Backend/
│   └── s3_backend.tf           # Defines S3 backend for remote state
│
├── Modules/
│   ├── EKS/                    # Module to create EKS cluster and node group
│   └── VPC/                    # Module to create VPC, subnets, gateways, etc.
│
├── main.tf                     # Root file — calls modules and builds infra
├── output.tf                   # Defines output values (VPC ID, cluster name, etc.)
└── variable.tf                 # Defines input variables for customization
```

## ⚙️ Prerequisites
-  AWS account with programmatic access (IAM user/role)  
-  Terraform installed locally  
-  AWS CLI installed and configured  
-  Sufficient permissions to create S3, DynamoDB, VPC, and EKS resources

---

## ⚙️ Terraform Commands — Step-by-Step Setup
Follow these steps to deploy your AWS infrastructure (VPC, EKS, S3, etc.) using Terraform.

### 🧩 1️⃣ Navigate to the Terraform backend directory
```bash
cd Terraform/Backend
```

### 🪣 2️⃣ Initialize Terraform
```bash
terraform init
```

### 🧮 3️⃣ Preview the changes (plan)
```bash
terraform plan
```

### 🧾 6️⃣ Apply the configuration (deploy the infra)
```bash
terraform apply
```
✅ Terraform will:
-  Create your VPC, subnets, Internet Gateway  
-  Launch the EKS cluster and node group  
-  Configure networking, IAM roles, and outputs

You’ll be prompted:
```
Do you want to perform these actions?
  Enter a value: yes
```
Type `yes` to confirm and start provisioning.

### 🧩 7️⃣ Verify the created resources
After apply completes, view outputs:
```bash
terraform output
```
✅ Displays details like:
-  EKS cluster name  
-  VPC ID  
-  Subnets

### 🧹 8️⃣ Destroy the infrastructure (when no longer needed)
```bash
terraform destroy
```
✅ Deletes all the AWS resources created by Terraform.