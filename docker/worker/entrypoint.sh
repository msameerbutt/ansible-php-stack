#!/bin/bash

# Run SSHD as Daemon
/usr/sbin/sshd -D

exec "$@"