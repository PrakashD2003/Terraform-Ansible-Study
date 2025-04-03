# Defining a group named "nginx_servers" for Nginx servers
[nginx_servers]
Linux_Server ansible_host=${Linux_Server_ip} ansible_user=ubuntu ansible_private_key_file=~/.ssh/Terraform-Server-Key.pem

# [nginx_servers] → Group name for servers running Nginx.
# Linux_Server → Alias for the server within the "nginx_servers" group.
# ansible_host=3.110.194.28 → Public IP address of the server.
# ansible_user=ubuntu → Correct SSH username for Ubuntu instances.
# ansible_private_key_file=~/.ssh/Linux_Server_AWS_Key.pem → SSH private key file.

# Defining a group named "apache_servers" for Apache servers
[apache_servers]
Terraform-Ansible-EC2 ansible_host=${Terraform-Ansible-EC2_ip} ansible_user=ubuntu ansible_private_key_file=~/.ssh/Terraform-Server-Key.pem ansible_python_interpreter=/usr/bin/python3

# [apache_servers] → Group name for servers running Apache.
# Terraform-Ansible-EC2 → Alias for the Apache server.
# ansible_host=43.204.228.174 → Public IP address of the server.
# ansible_user=ec2-user → Correct SSH username for Amazon Linux.
# ansible_private_key_file=~/.ssh/Terraform-Server-Key.pem → SSH private key file.  
