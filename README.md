# Ansible
This project for managing deployments using Ansible

# Ansible galaxy roles not installed in repo - Update all roles with this command
`ansible-galaxy install -r requirements.yml --force`

## Step to Simulate Production Deployment
1. docker-compose -f environments/prod.docker-compose.yml up -d
1. Run Playbook `ansible-playbook -i inventories/production playbooks/configure.playbook.yml`
1. Run Playbook `ansible-playbook -i inventories/production playbooks/install.playbook.yml`