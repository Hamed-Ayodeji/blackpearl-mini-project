#!/bin/bash

# This script is used to destroy the terraform configuration

# create a destroy function
function destroy() {
    # run terraform destroy
    terraform destroy -auto-approve
}

# check if the destroy was successful
if destroy; then
    echo "Terraform destroy was successful"
else
    echo "Terraform destroy failed"
fi

# navigate into the ansible directory
cd /home/jacksparrow/Work/Cloud-third-semester/mini-project/ansible


# navigate into the terraform directory
cd /home/jacksparrow/Work/Cloud-third-semester/mini-project/blackpearl-project