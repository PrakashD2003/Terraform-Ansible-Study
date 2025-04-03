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

# ----------------------------------------------
# 🔹 Generating Ansible Inventory File
# ----------------------------------------------

output "ansible_inventory" {
  # Using the 'templatefile' function to generate an inventory file dynamically
  value = templatefile("${path.module}/inventory.tpl", {
    Linux_Server_ip          = aws_instance.web_server.public_ip             # Replaces 'Linux_Server_ip' in the template with the EC2 public IP
    Terraform-Ansible-EC2_ip = aws_instance.terraform_plus_ansible.public_ip # Replaces 'Terraform-Ansible-EC2_ip' in the template with EC2 public IP
  })
}

# ----------------------------------------------
# 🔹 Creating Local Ansible Inventory File
# ----------------------------------------------

resource "local_file" "inventory" {
  content  = output.ansible_inventory.value                                          # The content of the file is the generated Ansible inventory
  filename = "/home/prakash_linux_wsl/Terraform-Ansible/Ansible-Setup/inventory.ini" # Specifies the absolute path to store the inventory file
}


