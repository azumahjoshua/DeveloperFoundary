# Deploy A Core Bank App on AWS Using Terraform

## Setting Up Terraform

### Step 1: Setting Up the VPC and Networking
- Create a VPC.
- Set up public and private subnets across two availability zones.
- Configure an Internet Gateway for public access.
- Add a NAT Gateway for private subnets to reach the internet.

### Step 2: Security Groups and IAM Roles
- Define security groups for each component.
- Restrict SSH access via a bastion host.
- Create IAM roles for EC2 instances.

### Step 3: Bastion Host (Jump Box)
- Deploy a Bastion Host in the public subnet.
- Allow only SSH access from specific IPs.

### Step 4: Internal Application Load Balancer
- Deploy an ALB in the public subnet.
- Attach Target Groups for EC2 instances.
- Enable Auto Scaling for EC2 instances.

### Step 5: EC2 Instances with Tomcat
- Deploy EC2 instances in private subnets.
- Install the Tomcat Server and deploy the Java application.

### Step 6: Database Layer
- Deploy Amazon RDS (Primary & Replica) in private subnets.
- Set up subnet groups and security groups.

### Step 7: Caching Layer
- Deploy Amazon ElastiCache (Redis) in private subnets.

### Step 8: Route 53 for Domain Resolution
- Set up Route 53 to point to the ALB.

---

## Deploy Atlantis Using Minikube in Kubernetes

### Prerequisites
- Install [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/)
- Install [Helm](https://helm.sh/docs/intro/install/)

### Step 1: Start Minikube
```sh
minikube start
```
### Step 2: Install Atlantis Using Helm using the default name space
Add the Atlantis Helm Chart Repository
```sh
helm repo add runatlantis https://runatlantis.github.io/helm-charts
helm repo update
```
Create a values.yaml File for Configuration
```sh
helm inspect values runatlantis/atlantis > values.yaml
```
Edit values.yaml to Add Access Credentials and Webhook Secret
```yaml
github:
  user: foo
  token: bar
  secret: baz
```
Set the Organization Allowlist
```yaml
orgAllowlist: github.com/runatlantis/*
```
Deploy Atlantis with the Custom Configuration
```sh
helm install atlantis runatlantis/atlantis -f values.yaml
```
### Step 4: Verify Deployment
```sh
kubectl get pods -n atlantis
```
### Step 5: Expose Atlantis Service
```sh
kubectl port-forward svc/atlantis 4141:80 -n atlantis
```