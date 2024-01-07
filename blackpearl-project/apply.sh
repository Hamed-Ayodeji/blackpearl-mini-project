#!/bin/bash

# This script is used to apply the terraform configuration

# create an apply function
function apply() {
    # run terraform apply
    terraform apply -auto-approve
}

# check if the apply was successful
if apply; then
    echo "Terraform apply was successful"
else
    echo "Terraform apply failed"
fi

# change mode of the generated blackpearl-key.pem file
chmod 400 blackpearl-key.pem

# navigate into the ansible directory
cd /home/jacksparrow/Work/Cloud-third-semester/mini-project/ansible

# run the ansible playbook
ansible-playbook apache2.yml

# check if the ansible playbook was successful
if [ $? -eq 0 ]; then
    echo "Ansible playbook was successful"
else
    echo "Ansible playbook failed"
fi

# navigate into the terraform directory
cd /home/jacksparrow/Work/Cloud-third-semester/mini-project/blackpearl-project