# Defining a group named "nginx_server" to manage one or more servers running Nginx
[nginx_server] 

# Adding a server named "Linux_Server" to the "nginx_server" group
Linux_Server ansible_host=${Linux_Server_ip} ansible_user=Linux_Server ansible_private_key_file=~/.ssh/Linux_Server_AWS_Key.pem

# [nginx_server] → This is a group name in Ansible used to categorize servers that run Nginx.
# Linux_Server → This is the alias for the server within the "nginx_server" group.
# ansible_host=${Linux_Server_ip} → Specifies the IP address of the Linux server. The actual IP will be dynamically assigned.
# ansible_user=Linux_Server → Defines the SSH user to connect to the Linux server.
# ansible_private_key_file=~/.ssh/Linux_Server_AWS_Key.pem → Specifies the private key file required for SSH authentication to the server.

# Defining a group named "apache_server" to manage one or more servers running Apache
[apache_server] 

# Adding a server named "Terraform-Ansible-EC2" to the "apache_server" group
Terraform-Ansible-EC2 ansible_host=${Terraform-Ansible-EC2_ip} ansible_user=Terraform-Ansible-EC2 ansible_private_key_file=~/.ssh/Terraform-Server-Key.pem

# [apache_server] → This is a group name in Ansible used to categorize servers that run Apache.
# Terraform-Ansible-EC2 → This is the alias for the server within the "apache_server" group.
# ansible_host=${Terraform-Ansible-EC2_ip} → Specifies the IP address of the Terraform-provisioned EC2 instance. The actual IP is dynamically assigned.
# ansible_user=Terraform-Ansible-EC2 → Defines the SSH user for connecting to the EC2 instance.
# ansible_private_key_file=~/.ssh/Terraform-Server-Key.pem → Specifies the private key file required for SSH authentication to this server.


