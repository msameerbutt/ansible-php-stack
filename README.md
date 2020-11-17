# Ansible
This project for managing deployments using Ansible.

## Deploymet Stack
1. PHP 7.4
1. Nginx 
1. Redis
1. MySQL
1. Mailhog

## Playbooks
A local docker based Ansible Master and Worker nodes are designed to replicate production server, All the playbooks cna be executed on local dev machine for funcional testing.

## Testing Steps
For testing purpose self SSL certificates and private ssh keys are included in the repository. (not a recommended practice)

1. From root folder `docker-compose -f environments/prod.docker-compose.yml up -d`
1. docker ps to ensure all container are up and running as per docker-compolse file
1. Jump into Ansible master container with `docker-compose -f environments/prod.docker-compose.yml exec master bash`
1. From Ansible master container execute the followng playbook `ansible-playbook -i inventories/production playbooks/configure.playbook.yml`

##  Ansible galaxy roles not installed in repo - Update all roles with this command
`ansible-galaxy install -r requirements.yml --force`
