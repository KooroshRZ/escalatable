#!/bin/bash

users=$(cat /root/creds.txt | cut -d ':' -f1)
creds=$(cat /root/creds.txt)

for user in $users; do
    deluser $user 2>/dev/null
    rm -rf /home/$user 2>/dev/null
    useradd $user -m -s /bin/bash
done

for cred in $creds; do
    echo $cred | chpasswd
done

/usr/sbin/sshd -D
# service ssh start
exec "$@"