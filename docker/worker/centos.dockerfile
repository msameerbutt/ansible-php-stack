FROM centos:7

# installing openssh server
RUN yum -y install openssh-server passwd python3 && pip3 install

# Create host ssh keys
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''

# Add node_user and its files to this machine
RUN useradd node_user && \
    echo "node_user_password" | passwd node_user --stdin && \
    mkdir -p /home/node_user/.ssh && \
    chmod 700 /home/node_user/.ssh && \
    touch /home/node_user/.ssh/authorized_keys && \
    chown node_user:node_user -R /home/node_user && \
    chmod 600 /home/node_user/.ssh/authorized_keys

RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config
 # http://stackoverflow.com/quessshtions/18173889/cannot-access-centos-sshd-on-docker
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config   

EXPOSE 22

CMD /usr/sbin/sshd -D