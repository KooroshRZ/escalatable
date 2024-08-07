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

    # chown root:$user /home/$user/level$level_index 
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


# fix permissions

#!/bin/bash

chown root:root /home/user0/
chown root:root /home/user1/
chown root:root /home/user2/
chown root:root /home/user3/
chown root:root /home/user4/
chown root:root /home/user5/
chown root:root /home/user6/
chown root:root /home/user7/
chown root:root /home/user8/
chown root:root /home/user9/
chown root:root /home/user10/


chmod 555 /home/user0/
chmod 555 /home/user1/
chmod 555 /home/user2/
chmod 555 /home/user3/
chmod 555 /home/user4/
chmod 555 /home/user5/
chmod 555 /home/user6/
chmod 555 /home/user7/
chmod 555 /home/user8/
chmod 555 /home/user9/
chmod 555 /home/user10/


chown user1:user0 /home/user0/level0
chown user2:user1 /home/user1/level1
chown user3:user2 /home/user2/level2
chown user4:user3 /home/user3/level3
chown user5:user4 /home/user4/level4
chown user6:user5 /home/user5/level5
chown user7:user6 /home/user6/level6
chown user8:user7 /home/user7/level7
chown user9:user8 /home/user8/level8
chown user10:user9 /home/user9/level9
chown user10:user10 /home/user10/level10


chmod 550 /home/user0/level0
chmod 550 /home/user1/level1
chmod 550 /home/user2/level2
chmod 550 /home/user3/level3
chmod 550 /home/user4/level4
chmod 550 /home/user5/level5
chmod 550 /home/user6/level6
chmod 550 /home/user7/level7
chmod 550 /home/user8/level8
chmod 550 /home/user9/level9
chmod 550 /home/user10/level10


cat /root/credentials.txt

/usr/sbin/sshd -D
exec "$@"