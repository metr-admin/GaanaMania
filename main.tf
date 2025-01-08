provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "web_app_vpc" {
  cidr_block = "10.0.0.0/24"
}

resource "aws_subnet" "web_app_subnet" {
  count = var.subnet_count
  vpc_id = aws_vpc.web_app_vpc.id
  cidr_block = cidrsubnet(aws_vpc.web_app_vpc.cidr_block, 8, count.index)
}

resource "aws_eks_cluster" "web_app_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = var.subnet_ids
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect    = "Allow"
        Sid       = ""
      },
    ]
  })
}