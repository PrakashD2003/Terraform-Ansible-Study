# -----------------------------------------------------
# Terraform Configuration for AWS EC2 Instance & Security Group
# This script provisions an EC2 instance and a security group
# Security Group allows SSH (22) and HTTP (80) access
# Nginx is installed on instance startup
# -----------------------------------------------------

# Specify Terraform version and required providers
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Ensures Terraform uses AWS provider v5.x
    }
  }
}

# Define the AWS Provider
provider "aws" {
  region = var.aws_region # AWS region is set using a variable
}

# Linking or Storing Terraform State file in Remote Database 
terraform {
  backend "s3" {
    bucket         = "s3-for-terraform-state31" # Name of the S3 bucket where the Terraform state file will be stored (must be lowercase & globally unique)
    key            = "terraform.tfstate"        # The path and name of the state file inside the S3 bucket.
    region         = "ap-south-1"               # The AWS region where the S3 bucket and DynamoDB table are located.
    dynamodb_table = "terraform-state-locks"    # Name of the DynamoDB table used for state locking.
    encrypt        = true                       # Ensures that the state file is encrypted using AES-256 encryption.
  }
}

# -----------------------------
# ≡ƒö╣ Security Group Definition
# -----------------------------
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow SSH and HTTP traffic"

  # ≡ƒö╣ Allow SSH (Port 22) from anywhere (for testing)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ΓÜá∩╕Å Open to all, restrict for production
  }

  # ≡ƒö╣ Allow HTTP (Port 80) for Web Traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP traffic from any IP
  }

  # ≡ƒö╣ Allow all outbound traffic (needed for package installation)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow outgoing traffic to any IP
  }

  tags = {
    Name = "Web-Server-Security-Group"
  }
}

# -----------------------------
# ≡ƒö╣ EC2 Instance Definition
# -----------------------------
resource "aws_instance" "web_server" {
  ami           = var.Amazon_Linux_AMI # AMI ID (Amazon Machine Image) from variables.tf
  instance_type = var.instance_type    # Instance type from variables.tf
  key_name      = var.key_pair         # SSH Key Pair Name

  # Attach Security Group to EC2
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # ≡ƒö╣ User Data - Install Nginx on Startup
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  # Assign a Name tag to the instance
  tags = {
    Name = "Terraform-Web-Server"
  }
}

resource "aws_instance" "terraform_plus_ansible" {
  ami           = var.Ubuntu_AMI
  instance_type = var.instance_type
  key_name      = var.key_pair

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "Terraform-Ansible-EC2"
  }

}
# Creating Multiple EC2 Instance (Ubuntu Instances)
resource "aws_instance" "Ubuntu_Instances" {
  count = 2 # Creates 2 Instances

  ami           = var.Ubuntu_AMI
  instance_type = var.instance_type
  key_name      = var.key_pair

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "Ubuntu_EC2-${count.index}"
  }
}

# Creating Multiple EC2 Instance (Amazon_Linux Instances)
resource "aws_instance" "Amazon_Linux_Instances" {
  count = 2

  ami           = var.Amazon_Linux_AMI
  instance_type = var.instance_type
  key_name      = var.key_pair

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "Amazon_Linux-EC2-${count.index}"
  }
}

# Creating Multiple EC2 Instances (RHEL Instances)
resource "aws_instance" "RHEL_Instances" {
  count = 2

  ami           = var.Red_Hat_AMI
  instance_type = var.instance_type
  key_name      = var.key_pair

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags = {
    Name = "RHEL-EC2-${count.index}"
  }
}

# -----------------------------
# ≡ƒö╣ S3 Bucket for Terraform State
# -----------------------------
resource "aws_s3_bucket" "terraform_state_s3" {
  bucket = "s3-for-terraform-state31" # Must be globally unique & all lowercase

  lifecycle {
    prevent_destroy = true # Prevents accidental deletion of the S3 bucket
  }
}

# Enable server-side encryption for the S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_encryption" {
  bucket = aws_s3_bucket.terraform_state_s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm # Uses AES-256 encryption
    }
  }
}

# Enable versioning for the S3 bucket to keep track of Terraform state changes
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state_s3.id

  versioning_configuration {
    status = "Enabled" # Enables versioning to keep multiple versions of Terraform state files
  }
}

# -----------------------------
# ≡ƒö╣ DynamoDB Table for State Locking
# -----------------------------
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locks" # Name of the DynamoDB table
  billing_mode = var.billing_mode        # PAY_PER_REQUEST (defined in variables.tf)

  # Define the primary key for the table
  attribute {
    name = "LockID" # Unique identifier for locking state
    type = "S"      # String type attribute
  }

  # Set LockID as the partition key
  hash_key = "LockID"

  # Enable point-in-time recovery for data protection
  point_in_time_recovery {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true # Prevents accidental deletion of the S3 bucket
  }
}

