FROM python:3.7.6-stretch

RUN pip install pip --upgrade
RUN pip install ansible

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    sshpass

WORKDIR /work

# Entrypoint
COPY ./entrypoint.sh /usr/local/bin/docker-entrypoint
COPY ./.bashrc /root/.bashrc

RUN mkdir /root/.ssh && \
    chmod +x /usr/local/bin/docker-entrypoint && \
    chmod +x /root/.bashrc

ENTRYPOINT ["docker-entrypoint"]