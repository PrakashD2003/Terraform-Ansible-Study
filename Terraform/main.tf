# ---------------------------
# Specify required provider
# ---------------------------
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws" # Provider source from HashiCorp registry
      version = "~> 5.0"        # Use AWS provider version 5.x
    }
  }
}

# -----------------------------------------
# Configure the AWS provider with region
# -----------------------------------------
provider "aws" {
  region = var.region # Region is defined as a variable in variables.tf
}

# --------------------------------------------------------
# Remote backend configuration for storing Terraform state
# --------------------------------------------------------
terraform {
  backend "s3" {
    bucket         = "s3-for-terraform-state31" # S3 bucket to store terraform.tfstate file
    key            = "terraform.tfstate"        # The path within the bucket
    region         = "ap-south-1"               # AWS region where the bucket is located
    dynamodb_table = "terraform-state-locks"    # DynamoDB table for state locking to prevent concurrent changes
    encrypt        = true                       # Enable server-side encryption of state file
  }
}

# -------------------------------------
# Create an AWS ECR (Elastic Container Registry) repository
# -------------------------------------
resource "aws_ecr_repository" "ecr_repo" {
  name = var.ecr_repo_name # Name of the repository taken from variable

  # Automatically scan images for vulnerabilities when pushed
  image_scanning_configuration {
    scan_on_push = true
  }

  # Use default encryption (AES256) for images
  encryption_configuration {
    encryption_type = "AES256"
  }

  # Allows deletion of the repository even if it contains images
  force_delete = true
}

# --------------------------------------------------------
# Add a lifecycle policy to manage untagged image cleanup
# --------------------------------------------------------
resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr_repo.name # Attach policy to the repository created above

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Remove untagged images older than 30 days"
        selection = {
          tagStatus   = "untagged"         # Apply rule only to untagged images
          countType   = "sinceImagePushed" # Use age since image push
          countUnit   = "days"
          countNumber = 30 # Images older than 30 days will be deleted
        }
        action = {
          type = "expire" # Expire (delete) the selected images
        }
      }
    ]
  })
}

