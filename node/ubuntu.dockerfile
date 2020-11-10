FROM ubuntu:trusty

# installing openssh server
RUN apt-get update && apt-get install -y openssh-server

RUN mkdir /var/run/sshd

# Create host ssh keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' -y
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N '' -y

# Add node_user and its files to this machine
RUN echo 'root:root_user' | chpasswd && \
    useradd node_user && \
    usermod -aG sudo node_user && \
    groupadd -g 10000 nginx && \
    echo "node_user:node_user_password" | chpasswd && \
    mkdir -p /home/node_user/.ssh && \
    chmod 700 /home/node_user/.ssh && \
    touch /home/node_user/.ssh/authorized_keys && \
    chown node_user:node_user -R /home/node_user && \
    chmod 600 /home/node_user/.ssh/authorized_keys && \
    echo 'node_user     ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22

# Entrypoint
COPY ./entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]

#CMD ["/usr/sbin/sshd", "-D"]
CMD ["bash"]