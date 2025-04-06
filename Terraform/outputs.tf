# ----------------------------------------------------------------------
# Output to display the URL of the created ECR repository
# ----------------------------------------------------------------------
output "ecr_repo_url" {
  description = "URL of the created ECR repository"
  value       = aws_ecr_repository.ecr_repo.repository_url
}

