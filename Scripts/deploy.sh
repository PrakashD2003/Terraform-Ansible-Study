#!/bin/bash

# -------------------------
# 🛠 Step 1: Run Terraform
# -------------------------
echo "🚀 Running Terraform..."
cd Terraform  # Navigate to the Terraform directory
terraform init  # Initialize Terraform (downloads required provider plugins)
terraform apply -auto-approve  # Apply the Terraform configuration (creates EC2 instances)

# ---------------------------------
# 🔍 Step 2: Fetch EC2 Public IPs
# ---------------------------------
echo "🔍 Fetching EC2 IPs..."

# Extract the public IPs of Ubuntu instances from Terraform output
UBUNTU_IPS=$(terraform output -json ubuntu_instance_ips | jq -r '.[]')

# Extract the public IPs of Amazon Linux instances from Terraform output
AMAZON_LINUX_IPS=$(terraform output -json amazon_linux_instance_ips | jq -r '.[]')

# Extract the public IPs of RHEL instances from Terraform output
RHEL_IPS=$(terraform output -json rhel_instance_ips | jq -r '.[]')

# ----------------------------------------
# 📄 Step 3: Update Ansible Inventory File
# ----------------------------------------
echo "📄 Updating Ansible inventory..."
cd ../Ansible  # Navigate to the Ansible directory

# Create a new inventory file and add Ubuntu instances
echo "[ubuntu]" > inventory.ini
for ip in $UBUNTU_IPS; do
  echo "$ip ansible_host=$ip ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/Terraform-Server-Key.pem" >> inventory.ini
done

# Add Amazon Linux instances to the inventory
echo "[amazon_linux]" >> inventory.ini
for ip in $AMAZON_LINUX_IPS; do
  echo "$ip ansible_host=$ip ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/Terraform-Server-Key.pem" >> inventory.ini
done

# Add RHEL instances to the inventory
echo "[rhel]" >> inventory.ini
for ip in $RHEL_IPS; do
  echo "$ip ansible_host=$ip ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/Terraform-Server-Key.pem" >> inventory.ini
done

# -----------------------------------------------------
# ⏳ Step 4: Wait for SSH to be Ready on All Instances
# -----------------------------------------------------
echo "⏳ Waiting for instances to be ready..."

# Check SSH connectivity on all instances
for ip in $UBUNTU_IPS $AMAZON_LINUX_IPS $RHEL_IPS; do
  while ! nc -z $ip 22; do  # Check if port 22 (SSH) is open
    sleep 5  # Wait for 5 seconds before retrying
  done
done

# ---------------------------------
# 📦 Step 5: Run Ansible Playbook
# ---------------------------------
echo "📦 Running Ansible Playbook..."
ansible-playbook -i inventory.ini ~/Terraform-Ansible/Ansible/playbooks/nginx-setup.yml  # Run Ansible playbook on the instances

# ------------------------------
# ✅ Step 6: Deployment Complete
# ------------------------------
echo "✅ Deployment Completed Successfully!"

