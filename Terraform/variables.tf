# -----------------------------------------------
# 🔹 Terraform Variables (Customizable Settings)
# -----------------------------------------------

# 🔹 Define AWS region (Default: us-east-1)
variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "ap-south-1"
}

# Define AMI ID (Amazon_Linux)
variable "Amazon_Linux_AMI" {
  description = "Amazon Linux AMI ID for EC2 Instance"
  default = "ami-002f6e91abff6eb96" # AMI ID 
}

# Define AMI ID (Red_Hat)
variable "Red_Hat_AMI" {
  description = "Red Hat AMI ID for EC2 Insatance"
  default = "ami-0402e56c0a7afb78f" # AMI ID
}

# Define AMI ID (Ubuntu)
variable "Ubuntu_AMI" {
  description = "Ubuntu AMI ID for EC2 Instance"
  default     = "ami-0e35ddab05955cf57" # AMI ID
}

# 🔹 Define Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro" # Free-tier eligible
}

# 🔹 Define Key Pair Name for SSH Access
variable "key_pair" {
  description = "AWS Key Pair Name for SSH access"
  default     = "Terraform-Server-Key" # AWS key pair name
}

variable "sse_algorithm" {
  description = " Enrytion Technique to be used on data Objet"
  default     = "AES256" # Uses AES-256 encryption for all objects in the bucket
}

variable "billing_mode" {
  description = "Payment Mode to be used for DynamoDB"
  default     = "PAY_PER_REQUEST" # Charges based on the number of read/write requests instead of fixed capacity
}
