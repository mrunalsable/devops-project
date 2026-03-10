# End-to-End DevOps Project 🚀

A production-grade CI/CD pipeline built on AWS using modern DevOps tools.

## Architecture
```
Developer → GitHub → Jenkins → Docker → DockerHub → Kubernetes (K3s)
```

## Tech Stack

| Tool | Purpose |
|------|---------|
| Terraform | Infrastructure as Code (AWS provisioning) |
| Ansible | Configuration Management |
| Jenkins | CI/CD Pipeline |
| Docker | Containerization |
| Kubernetes (K3s) | Container Orchestration |
| AWS EC2 | Cloud Infrastructure |
| Python Flask | Sample Application |

## Infrastructure

- **Control Machine**: Kali Linux (Ansible + Terraform + AWS CLI)
- **EC2 Instance 1**: Jenkins + Docker (CI Server) - t2.micro
- **EC2 Instance 2**: K3s Kubernetes Cluster - t2.micro

## Project Structure
```
devops-project/
├── terraform/
│   ├── main.tf              # VPC, Subnet, IGW, Route Table
│   ├── security_groups.tf   # Firewall rules
│   ├── ec2.tf               # EC2 instances
│   ├── variables.tf         # Input variables
│   └── outputs.tf           # Output values
├── ansible/
│   ├── inventory.ini        # EC2 hosts
│   ├── ansible.cfg          # Ansible configuration
│   ├── playbooks/
│   │   ├── jenkins.yml      # Jenkins + Docker setup
│   │   └── k8s.yml          # K3s setup
│   └── roles/
│       ├── docker/          # Docker installation role
│       ├── jenkins/         # Jenkins installation role
│       └── k3s/             # K3s installation role
├── app/
│   ├── app.py               # Flask application
│   ├── requirements.txt     # Python dependencies
│   └── Dockerfile           # Container definition
├── kubernetes/
│   ├── deployment.yml       # K8s Deployment
│   └── service.yml          # K8s Service (NodePort)
├── Jenkinsfile              # Pipeline definition
└── README.md                # Project documentation
```

## Pipeline Flow
```
1. Developer pushes code to GitHub
2. GitHub Webhook triggers Jenkins
3. Jenkins pulls latest code
4. Docker image built and tagged
5. Image pushed to DockerHub
6. Kubernetes deployment updated
7. Rolling update deployed to K3s
8. App live and accessible
```

## Setup Guide

### Prerequisites
- AWS Account with IAM credentials
- Kali Linux / Ubuntu machine
- GitHub account
- DockerHub account

### Phase 1 — Install Tools
```bash
# Install Terraform, Ansible, AWS CLI, kubectl
# See docs/phase1-setup.md
```

### Phase 2 — Provision Infrastructure
```bash
cd terraform/
terraform init
terraform plan
terraform apply
```

### Phase 3 — Configure Jenkins
```bash
cd ansible/
ansible-playbook playbooks/jenkins.yml
```

### Phase 4 — Configure Kubernetes
```bash
ansible-playbook playbooks/k8s.yml
```

### Phase 5 — Setup Pipeline
```
1. Add DockerHub credentials in Jenkins
2. Create Pipeline job pointing to this repo
3. Add GitHub webhook
4. Push code to trigger pipeline
```

## Live Demo

- **Jenkins UI**: http://JENKINS_IP:8080
- **Flask App**: http://K8S_IP:30080
- **Health Check**: http://K8S_IP:30080/health

## Key Learnings

- Infrastructure as Code using Terraform
- Configuration Management using Ansible
- Containerization with Docker
- Container Orchestration with Kubernetes
- CI/CD Pipeline with Jenkins
- AWS cloud infrastructure management
- GitHub webhook integration

## Author

**Mrunal Sable**
- GitHub: [@mrunalsable](https://github.com/mrunalsable)
