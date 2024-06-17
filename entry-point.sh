#!/bin/bash

for i in $(seq 0 10); do
    password=$(cat /dev/urandom | head -c 8 | xxd -p)
    echo "user${i}:${password}" >> /root/credentials.txt
done

users=$(cat /root/credentials.txt | cut -d ':' -f1)
creds=$(cat /root/credentials.txt)
cat /dev/urandom | head -c 16 | xxd -p > /root/zodd_password.txt
chmod 400 /root/zodd_password.txt

let "level_index = 0"

for user in $users; do

    deluser $user 2>/dev/null
    rm -rf /home/$user 2>/dev/null

    useradd $user -m -s /bin/bash
    chmod +x /home/$user/
    chmod o-x /home/$user/
    cp /root/challenges/level$level_index /home/$user/

    chown root:$user /home/$user/level$level_index 
    chmod 555  /home/$user/level$level_index
    let "level_index = level_index + 1"

    chmod -w /home/$user
    
done

cp /root/challenges/Zodd.py /home/user10/Zodd.py
chmod +x /home/user10/Zodd.py


let "file_index = 0"
for group_index in $(seq 1 10); do
    chgrp user$group_index /home/user$file_index/level$file_index
    chgrp user$group_index /home/user$file_index/
    let "file_index = file_index + 1"
done

# sudo
echo "user0 ALL=(user1) NOPASSWD: /home/user0/level0" >> /etc/sudoers
echo "user1 ALL=(user2) NOPASSWD: /home/user1/level1" >> /etc/sudoers
echo "user2 ALL=(user3) NOPASSWD:SETENV: /home/user2/level2" >> /etc/sudoers
echo "user3 ALL=(user4) NOPASSWD: /home/user3/level3" >> /etc/sudoers
echo "user4 ALL=(user5) NOPASSWD: /home/user4/level4" >> /etc/sudoers
echo "user5 ALL=(user6) NOPASSWD: /home/user5/level5" >> /etc/sudoers
echo "user6 ALL=(user7) NOPASSWD: /home/user6/level6" >> /etc/sudoers
echo "user7 ALL=(user8) NOPASSWD: /home/user7/level7" >> /etc/sudoers
echo "user8 ALL=(user9) NOPASSWD: /home/user8/level8" >> /etc/sudoers
echo "user9 ALL=(user10) NOPASSWD: /home/user9/level9" >> /etc/sudoers
echo "user10 ALL=(root) NOPASSWD: /home/user10/Zodd.py" >> /etc/sudoers

echo '/usr/bin/id' > /home/user1/check_id.sh
chmod 555 /home/user1/check_id.sh
chown root:user2 /home/user1/check_id.sh


let "user_index = 0"
for cred in $creds; do
    echo $cred | chpasswd
    echo $cred > /home/user${user_index}/cred${user_index}.txt
    chown root:user$user_index /home/user$user_index/cred$user_index.txt
    # chown user$user_index /home/user${user_index}/cred${user_index}.txt
    chmod 440 /home/user${user_index}/cred${user_index}.txt
    let "user_index = user_index + 1"
done

cat /root/credentials.txt

/usr/sbin/sshd -D
exec "$@"