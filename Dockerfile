FROM ubuntu:latest
RUN apt-get update && apt-get install -y openssh-server neovim nano gcc sudo
RUN mkdir /var/run/sshd &&\
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/;s/#Banner none/Banner \/etc\/issue/' /etc/ssh/sshd_config &&\
    echo > /etc/issue
COPY banner /etc/motd
COPY entry-point.sh /root/entry-point.sh
COPY creds.txt /root/creds.txt
COPY challenges /root/challenges
EXPOSE 22
ENTRYPOINT ["/root/entry-point.sh"]