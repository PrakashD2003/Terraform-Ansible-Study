# -----------------------------------------------
# Variable to specify the AWS region for deployment
# -----------------------------------------------
variable "region" {
  description = "AWS region where resources will be created"
  default     = "ap-south-1" # Default set to Mumbai region (Asia Pacific South 1)
}

# ------------------------------------------------------
# Variable to define the name of the ECR repository
# ------------------------------------------------------
variable "ecr_repo_name" {
  description = "Repository Name"
  default     = "docker-study-ecr" # Default ECR repo name used in the main configuration
}

