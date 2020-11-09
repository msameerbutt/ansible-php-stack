#!usr/bin/env bash

# Add Private Key to SSH Agent
if [ -f "/run/secrets/id_rsa" ]; then
    echo "Add into known hosts"
    ssh-keyscan -H app.${APP_ENV}.host1 >> ~/.ssh/known_hosts
    ssh-keyscan -H app.${APP_ENV}.host2 >> ~/.ssh/known_hosts
    ssh-keyscan -H app.${APP_ENV}.db1 >> ~/.ssh/known_hosts
    ssh-keyscan -H app.${APP_ENV}.redis >> ~/.ssh/known_hosts
    ssh-keyscan -H app.${APP_ENV}.mail >> ~/.ssh/known_hosts
        
    echo "Add key into ssh-agent"
    eval "$(ssh-agent -s)"
    ssh-add -k /run/secrets/id_rsa    
fi

#current environment
echo "Enivornment: $APP_ENV"