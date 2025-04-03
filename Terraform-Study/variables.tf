# -----------------------------------------------
# 🔹 Terraform Variables (Customizable Settings)
# -----------------------------------------------

# 🔹 Define AWS region (Default: us-east-1)
variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "ap-south-1"
}

# 🔹 Define AMI ID (Amazon Linux 2 AMI)
variable "ami_id" {
  description = "AMI ID for EC2 instance"
  default     = "ami-0e35ddab05955cf57" # AMI ID
}

# Define AMI ID (Ubuntu)
variable "ami_id_ubuntu" {
  description = "Ubuntu AMI ID for EC2 Instance"
  default     = "ami-0f2e255ec956ade7f" # AMI ID
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
