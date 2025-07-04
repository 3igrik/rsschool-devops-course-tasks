# Terraform Infrastructure Setup for AWS

This repository contains Terraform configuration to set up AWS infrastructure for storing Terraform state and enabling GitHub Actions to deploy resources securely. The setup includes an S3 bucket for state storage, a DynamoDB table for state locking, and an IAM role for GitHub Actions with OIDC authentication.

## Infrastructure Overview

- **AWS S3 Bucket**: Stores Terraform state files securely.
  - Name: `3igrik-rs-tf-state-2025`
  - Region: `eu-north-1`
  - Features: Versioning enabled, server-side encryption (AES256), public access blocked.
- **AWS DynamoDB Table**: Provides state locking to prevent concurrent modifications.
  - Name: `terraform-state-lock`
  - Region: `eu-north-1`
  - Partition Key: `LockID` (String)
  - Billing Mode: Pay-per-request
- **IAM Role**: Allows GitHub Actions to interact with AWS resources securely via OIDC.
  - Name: `GithubActionsRole`
  - Policies: `AmazonEC2FullAccess`, `AmazonRoute53FullAccess`, `AmazonS3FullAccess`, `IAMFullAccess`, `AmazonVPCFullAccess`, `AmazonSQSFullAccess`, `AmazonEventBridgeFullAccess`
  - Trust Policy: Configured for GitHub OIDC with repository `3igrik/rsschool-devops-course-tasks`

## Prerequisites

- **AWS Account**: Ensure you have an AWS account (ID: `621837861588`) with a user (`rsschool-devops`) that has permissions to manage S3, DynamoDB, and IAM.
- **Terraform**: Install Terraform (version 1.9.8 or compatible) on your local machine.
- **GitHub Repository**: Clone this repository (`3igrik/rsschool-devops-course-tasks`) and ensure you have push access.
- **AWS CLI**: Configured with credentials for the `rsschool-devops` user.

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/3igrik/rsschool-devops-course-tasks.git
cd rsschool-devops-course-tasks
```

## Infrastructure Overview

- **VPC**: A virtual network (`main-vpc`) with CIDR `10.0.0.0/16` in region `eu-north-1`.
- **Public Subnets**: Two subnets (`public-subnet-1`, `public-subnet-2`) in AZs `eu-north-1a` and `eu-north-1b` with CIDR `10.0.1.0/24` and `10.0.2.0/24`. Instances have public IPs and internet access via an Internet Gateway.
- **Private Subnets**: Two subnets (`private-subnet-1`, `private-subnet-2`) in AZs `eu-north-1a` and `eu-north-1b` with CIDR `10.0.3.0/24` and `10.0.4.0/24`. Isolated from the internet but can communicate with other subnets in the VPC.
- **Internet Gateway**: Attached to the VPC (`main-igw`) for public subnet internet access.
- **NAT Gateway**: Deployed in public-subnet-1 (main-nat) with an Elastic IP, allowing private subnets to access the internet for outbound traffic.
- **Security Groups**:
  `bastion-sg`: Allows SSH (port 22) from a specified CIDR (default: 0.0.0.0/0, recommended to restrict to your IP).
  `private-sg`: Allows SSH from bastion-sg and all outbound traffic.
- **Bastion Host**: An EC2 instance (bastion-host) in public-subnet-1 using Amazon Linux 2023 AMI and `t4g.nano` instance type, serving as a secure entry point to private subnets.
- **Routing**:
  - Public subnets use a route table with a route to the Internet Gateway (`0.0.0.0/0`).
  - Private subnets use a separate route table with local routing only.
  - All subnets can communicate with each other via the VPC's local route (`10.0.0.0/16`).

## Project Structure

- `vpc.tf`: Defines the VPC and Internet Gateway.
- `subnets.tf`: Defines public and private subnets.
- `nat.tf`: Defines NAT Gateway and Elastic IP.
- `route_tables.tf`: Defines route tables and associations.
- `security_groups.tf`: Defines security groups for bastion host and private subnets.
- `private-nacl.tf`, `public-nacl.tf`: Defines Network ACLs for public and private subnets.
- `bastion.tf`: Defines the bastion host EC2 instance.
- `variables.tf`: Defines input variables.
- `iam.tf`: Defines IAM roles for GitHub Actions.
- `backend.tf`: Configures S3 backend for Terraform state.
