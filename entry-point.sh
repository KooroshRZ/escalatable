#!/bin/bash

users=$(cat /root/creds.txt | cut -d ':' -f1)
creds=$(cat /root/creds.txt)

let "level_index = 0"

for user in $users; do

    deluser $user 2>/dev/null
    rm -rf /home/$user 2>/dev/null

    useradd $user -m -s /bin/bash
    chmod +x /home/$user/
    cp /root/challenges/level$level_index /home/$user/

    chown $user /home/$user/level$level_index 
    chmod 555  /home/$user/level$level_index
    let "level_index = level_index + 1"
    
done

# sudo
echo "user0 ALL=(user1) NOPASSWD: /home/user0/level0" >> /etc/sudoers
echo "user1 ALL=(user2) NOPASSWD:SETENV: /home/user1/level1" >> /etc/sudoers


let "user_index = 0"
for cred in $creds; do
    echo $cred | chpasswd
    echo $cred > /home/user${user_index}/cred${user_index}.txt
    chown user$user_index /home/user${user_index}/cred${user_index}.txt
    chmod 400 /home/user${user_index}/cred${user_index}.txt
    let "user_index = user_index + 1"
done

/usr/sbin/sshd -D
exec "$@"