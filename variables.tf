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
  default     = "3igril/rsschool-devops-course-tasks"
}