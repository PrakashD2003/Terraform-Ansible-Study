# Terraform & Ansible Automated Infrastructure Deployment

## Overview
This project automates the provisioning and configuration of an AWS EC2 instance using Terraform and Ansible. It also sets up an Nginx web server with a custom HTML page.

## Project Structure

```
├── deploy.sh              # Shell script for automating Terraform and Ansible execution
├── main.tf                # Terraform configuration for provisioning AWS infrastructure
├── outputs.tf             # Defines output variables to retrieve EC2 instance details
├── variables.tf           # Declares variables used in Terraform configuration
├── nginx-setup.yml        # Ansible playbook to install and configure Nginx on EC2 instance
├── index.html             # Webpage served by the Nginx server
```

## Files & Their Roles

### 1. `deploy.sh` (Shell Script for Automation)
This script automates the execution of Terraform and Ansible. It performs the following actions:
- Initializes Terraform
- Applies Terraform configuration to provision EC2 instance(s)
- Extracts the public IP of the created EC2 instance(s)
- Runs the Ansible playbook to configure the instance(s) with Nginx

### 2. `main.tf` (Terraform Configuration)
Defines the AWS infrastructure components such as:
- AWS provider
- EC2 instance(s) setup
- Security group allowing SSH (22) and HTTP (80) access

### 3. `outputs.tf` (Terraform Outputs)
Retrieves and displays key details like:
- Public IP of the EC2 instance
- Instance ID

### 4. `variables.tf` (Terraform Variables)
Defines configurable variables such as:
- AWS region
- Instance type
- AMI ID
- SSH Key Name

### 5. `nginx-setup.yml` (Ansible Playbook)
Configures the EC2 instance by:
- Installing Nginx
- Copying the custom `index.html` to the web server directory
- Restarting the Nginx service

### 6. `index.html` (Webpage Content)
Simple HTML file that is deployed to the server, displaying:
```
Hello from Ansible-managed Nginx!
```

## Usage Instructions

### Step 1: Configure AWS Credentials
Ensure you have AWS CLI configured with valid credentials:
```sh
aws configure
```

### Step 2: Run the Deployment Script
Make the script executable and execute it:
```sh
chmod +x deploy.sh
./deploy.sh
```

### Step 3: Access the Web Server
After successful deployment, obtain the public IP from Terraform output and visit:
```
http://<EC2_PUBLIC_IP>
```

## Prerequisites
- AWS Account
- Terraform Installed
- Ansible Installed
- SSH Key Pair for EC2
- AWS CLI (optional for credential management)

## Summary
This project streamlines infrastructure provisioning and configuration using Terraform and Ansible, making it efficient and scalable for automated deployments.


