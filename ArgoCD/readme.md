# ArgoCD for Deployment

🚀 Step 1 — Install Argo CD on EKS  
Once EC2 is connected to the EKS cluster (which we did in Kubernetes setup), install Argo CD:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

Check the status:
```bash
kubectl get pods -n argocd
```
Wait until all pods are Running.

---

🌐 Step 2 — Access the Argo CD UI  
Expose Argo CD via a LoadBalancer service:

```bash
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

Then check:
```bash
kubectl get svc argocd-server -n argocd
```

Once the EXTERNAL-IP field appears, copy that address and open it in your browser.

---

🧑‍💻 Login Credentials  
Get the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 --decode
```

Login as:
- Username: `admin`  
- Password: (the output from above)  

Change the password immediately after login.

---

🔗 Step 3 — Connect GitHub Repository in Argo CD
1. Go to Argo CD UI → Settings → Repositories  
2. Click **Connect Repo** using HTTPS  
3. Fill in:
   - Repository URL: `https://github.com/I-am-nk/hello-world-node-app.git`  
   - Username/Password: leave empty if public  
   - Click Connect  
4. Go to **Applications** → **Create Application**  
5. Fill in details:
   - Application Name: `hello-world-node-app`
   - Project: `default`
   - Sync Policy: `Automatic`
   - Repository URL: same GitHub repo
   - Revision: `HEAD`
   - Path: `Kubernetes`
   - Cluster URL: `https://kubernetes.default.svc`
   - Namespace: `default`
6. Click **Create**

Argo CD will sync your repo and deploy your app automatically 🎯

---

🌍 Step 4 — Verify the Deployed Application

```bash
kubectl get svc hello-world-node-app -n default
```

Once the EXTERNAL-IP shows up, visit that URL in your browser —  
You’ll see your Node.js Hello World app running on AWS EKS 🎉

---

🧠 Recap

| Step | Description |
|------|-------------|
| 1 | Create IAM Role (`eks-bastion-role`) with EKS + ECR policies |
| 2 | Launch Ubuntu EC2 in same VPC + public subnet |
| 3 | Connect to EC2 and install AWS CLI + kubectl |
| 4 | Connect EC2 to EKS using `aws eks update-kubeconfig` |
| 5 | Install Argo CD on the EKS cluster |
| 6 | Expose Argo CD using LoadBalancer |
| 7 | Connect GitHub repo in Argo CD |
| 8 | Verify app deployment from GitHub to EKS |