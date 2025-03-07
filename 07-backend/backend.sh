#!/bin/bash
comp=$1
env=$2
echo "Component is:$comp, Environment is: $env"
sudo dnf install ansible -y
ansible-pull -i localhost, -U https://github.com/aikdp/expense-ansible-tf-roles.git main.yaml -e component=$comp -e environment=$env

#passing terraform variables to shell, shell to ansible

#in command line, we are passing to ansible playbook variables
#ansible vars-- component , environment

#shell vars== comp  , env

#terraform variables-=--- var.component   var.environment


