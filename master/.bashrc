#!usr/bin/env bash

# Add Private Key to SSH Agent
if [ -f "/run/secrets/id_rsa" ]; then
    echo "Add into known hosts"
    ssh-keyscan -H app.prod.host1 >> ~/.ssh/known_hosts
    ssh-keyscan -H app.prod.host2 >> ~/.ssh/known_hosts
    ssh-keyscan -H node3 >> ~/.ssh/known_hosts
    ssh-keyscan -H node4 >> ~/.ssh/known_hosts
    ssh-keyscan -H node5 >> ~/.ssh/known_hosts
        
    echo "Add key into ssh-agent"
    eval "$(ssh-agent -s)"
    ssh-add -k /run/secrets/id_rsa    
fi

#current environment
echo "Enivornment: $APP_ENV"