#!/bin/bash

if [ -f "/run/secrets/id_rsa" ]; then
    echo "Add into known hosts"
    # ssh-keyscan github.com > /root/.ssh/known_hosts
    ssh-keyscan -H node1 >> ~/.ssh/known_hosts
    ssh-keyscan -H node2 >> ~/.ssh/known_hosts
    ssh-keyscan -H node3 >> ~/.ssh/known_hosts
    ssh-keyscan -H node4 >> ~/.ssh/known_hosts
    ssh-keyscan -H node5 >> ~/.ssh/known_hosts

    #echo "Add key into ssh-agent"
    # eval "$(ssh-agent -s)"
    # ssh-add -k /run/secrets/id_rsa

    # now execute commands to connect your nodes to do anything via ssh
    # echo "Testing ansible pint to hosts"
    # ansible all -i inventories/demo -m ping

    # now execute ansible playbook
    # echo "Testing ansible pint to hosts"
    # ansible-playbook -i inventories/demo playbooks/demo.yml
fi

exec "$@"