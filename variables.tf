variable "aws_region" {
  description = "The AWS region where the resources will be created"
  type        = string
  default     = "us-east-1"  # Based on the availability zones (us-east-1a, us-east-1b)
}

variable "subnet_count" {
  description = "The number of subnets to create for the web app"
  type        = number
  default     = 2  # Based on the output of the describe-subnets command (2 subnets listed)
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "web-app-cluster"
}

variable "eks_role_name" {
  description = "The name of the IAM role for the EKS cluster"
  type        = string
  default     = "eks-cluster-role"
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the EKS cluster"
  type        = list(string)
}