variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-north-1"
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket for Terraform state"
  type        = string
  default     = "3igrik-rs-tf-state-2025"
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table for state locking"
  type        = string
  default     = "terraform-state-lock"
}

variable "github_repo" {
  description = "GitHub repository for OIDC trust policy (format: org/repo)"
  type        = string
  default     = "3igrik/rsschool-devops-course-tasks"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  type        = string
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  type        = string
  default     = "10.0.4.0/24"
}

variable "az_1" {
  description = "Availability Zone 1"
  type        = string
  default     = "eu-north-1a"
}

variable "az_2" {
  description = "Availability Zone 2"
  type        = string
  default     = "eu-north-1b"
}

variable "bastion_ami" {
  description = "AMI ID for the bastion host (Amazon Linux 2023)"
  type        = string
  default     = "ami-012e1773308038949"
}

variable "bastion_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t4g.nano"
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair for the bastion host"
  type        = string
  default     = "3igrik-key-pair"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into the bastion host"
  type        = string
  default     = "2.132.80.254/32" # IP
}