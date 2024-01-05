#!/bin/bash

# Ask for AWS access key and secret key
echo "Enter your AWS access key:"
read -r access_key
echo "Enter your AWS secret key:"
read -r secret_key

cd terraform-aws && \
# Initialize Terraform with AWS credentials
terraform init
# Provision infrastructure with Terraform
terraform apply -auto-approve -var "aws_access_key=$access_key" -var "aws_secret_key=$secret_key"

# Get the IP address of the provisioned instance(s)
buildserver_ip=$(terraform output buildserver_public_ip | tr -d '"')
dbserver_ip=$(terraform output db_server_public_ip | tr -d '"')

# Wait for SSH to be available on the instance(s)
while ! nc -zv "$buildserver_ip" 22; do
  sleep 5
done

while ! nc -zv "$dbserver_ip" 22; do
  sleep 5
done
# Run Ansible playbook to configure the instance(s)
cd ../ansible

ansible-playbook dbserver.yml -e @group_vars/vault.yml
echo "Add this IP to DNS Provider $buildserver_ip"

read -p "Would you like to proceed with Letsencrypt? (y/n): " proceed

if [[ $proceed == [yY] ]]; then
    echo "Running with Letsencrypt"
    ansible-playbook buildserver.yml -e @group_vars/vault.yml -e @group_vars/aws.yml && \
    ansible-playbook letsencrypt.yml -e @group_vars/vault.yml
else
    echo "Proceeding without Letsencrypt"
    ansible-playbook buildserver.yml -e @group_vars/vault.yml -e @group_vars/aws.yml
fi






    

