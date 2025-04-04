# ----------------------------------------------
# 🔹 Terraform Output (Displays EC2 Public IP)
# ----------------------------------------------

# Defining an output variable to store the public IP of the Linux Server instance
output "Linux_Server_ip" {
  description = "Public IP of the EC2 instance"   # A short description of what this output represents
  value       = aws_instance.web_server.public_ip # Retrieves the public IP of the "web_server" EC2 instance
}

# Defining an output variable to store the public IP of the Terraform-Ansible EC2 instance
output "Terraform-Ansible-EC2_ip" {
  description = "Public IP of the EC2 instance"               # Description of the output variable
  value       = aws_instance.terraform_plus_ansible.public_ip # Retrieves the public IP of the "terraform_plus_ansible" EC2 instance
}

# Defining an output variable to store the public IP of the Ubuntu Instances EC2 instance                         
output "ubuntu_instance_ips" {
  description = "Public IPs of All Ubuntu_Intances"
  value = aws_instance.Ubuntu_Instances[*].public_ip # Stores IPs of all EC2                                                                                 
 } 

# Defining an output variable to store the public IP of the Amazon_Linux Instances EC2 instance 
output "amazon_linux_instance_ips" {
  description = "Public IPs of All Amazon_Linux_Instance"
  value = aws_instance.Amazon_Linux_Instances[*].public_ip
}

# Defining an output variable to store the public IP of the RHEL Instances EC2 instance 
output "rhel_instance_ips" {
  description = "Public IPs of All RHEL_Instance"
  value = aws_instance.RHEL_Instances[*].public_ip
}
