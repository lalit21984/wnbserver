---
# WandB Server on AWS with Terraform

This repository provides a setup for deploying a **Weights & Biases (WandB)** server on AWS using **Terraform** as Infrastructure as a code for deployment. The goal is to demonstrate how you can quickly spin up a WandB server in a cloud environment for experimentation and collaboration.

## Prerequisites

Before you begin, ensure you have the following tools installed:

- **AWS CLI** - For interacting with AWS resources.
  - [AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- **Terraform** - For provisioning AWS infrastructure.
  - [Terraform Installation](https://www.terraform.io/downloads.html)
- **Helm** - For deploying applications to Kubernetes.
  - [Helm Installation](https://helm.sh/docs/intro/install/)
- **kubectl** - For interacting with Kubernetes clusters.
  - [kubectl Installation](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- **AWS EKS Cluster** - A Kubernetes cluster provisioned on AWS EKS.
  - [Setting up EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started.html)
- **Python** - for writing code for wandb runs.
  - [https://www.python.org/downloads/release/python-3131/]


![image](https://github.com/user-attachments/assets/dcbab4f9-cab3-4845-9c56-eae5230b375f)




## Project Structure

```
```
.
├── terraform
│   ├── main.tf            # Terraform main file for AWS setup
│   ├── variables.tf       # Terraform variables
│   ├── terraform.tfvars   # Terraform Variables
│   └── providers.tf       # AWS provider configuration
└── README.md              # This readme file
```
```

## Overview

This PoC will help you provision AWS resources using Terraform, create a Kubernetes cluster on **Amazon EKS**, and deploy **WandB Server**

### High-Level Steps

1. **Provision AWS Infrastructure**: Terraform will provision the necessary AWS resources (e.g., VPC, subnets, EKS Cluster).
2. **Deploy WandB Server on EKS**: Using Helm, we will deploy the WandB server to the Kubernetes cluster.
3. **Access the WandB Server**: Once the server is up, you will be able to access it via a publicly available DNS Url.

## Getting Started

Step 1: Clone the Repository

First, navigate to the directory and clone the repository:

```bash
git clone <your-repo-url>
cd terraform

Step 2: Install Terraform
Make sure Terraform is installed on your system. You can find installation instructions here.

Step 3: Create terraform file structure with main.tf, terraform.tfvars, variables.tf, versions.tf.

Step 4: Set Up AWS Credentials

Ensure that your AWS CLI is configured with the necessary permissions.

```bash
aws configure
```

Make sure you have permissions to create resources such as EC2, EKS, VPC, IAM roles, etc.

Step 5: Provision AWS Infrastructure with Terraform

Navigate to the `terraform` directory.

```bash
cd terraform
```

#### Initialize Terraform

```bash
terraform init
```
#### Format and Validate Terraform Template

```bash
terraform fmt
terraform validate
```
#### Plan and Apply the Terraform Configuration

To provision the resources, run:

```bash
terraform plan
terraform apply
```

This will ask you to confirm before applying changes. After successful execution, Terraform will output your EKS cluster endpoint and other resources.

Step 6: Set Up kubectl to Access EKS Cluster

Once the infrastructure is provisioned, configure your `kubectl` to access the newly created EKS cluster.

```bash
aws eks --region <region> update-kubeconfig --name <cluster-name>
```

Verify the kubernetes installation and node details:

```bash
kubectl get nodes
```

This will deploy the WandB server into your EKS cluster.

Step 7: Access WandB Server

Once the deployment is complete, you can access the WandB server using the Route53 public url IP created by the terraform i.e www.wnb.lalitkumarsahu.com. You can get the URL with the output variable in terraform cli.


Step 8: Login to the WandB Server

After accessing the URL, use your **WandB API Key** to log in and start using the server.

If you don't have an API key, you can create one by signing up on [WandB](https://wandb.ai/).

## Variables

The terraform/variables.tf file contains the following configurable variables:

namespace: Prefix for resource names.
domain_name: The domain name for the WandB server.
subdomain: Subdomain for the WandB server.
engine_version: RDS MySQL Aurora database engine version.
license: WandB license key.
zone_id: The Route 53 hosted zone ID.

## Outputs

After Terraform execution, the following outputs will be available:

public_url
s3_bucket

## Clean Up

To clean up the infrastructure and remove all the AWS resources:
 Destroy the Terraform resources:

   ```bash
   cd terraform
   terraform destroy
   ```

## Troubleshooting

- **Helm chart deployment issues**: Make sure that your Kubernetes context is set correctly and that your EKS cluster is running.
- **AWS Permissions**: Ensure that your AWS user has the appropriate permissions to provision resources like EKS, VPC, IAM roles, etc.
- **Timeout errors**: It may take a few minutes for EKS and the WandB server to fully deploy and become accessible.

## Contributing

If you find any issues or have improvements to suggest, feel free to open an issue or submit a pull request. Contributions are welcome!

---
