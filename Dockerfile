FROM ubuntu:latest
RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
COPY entry-point.sh /root/entry-point.sh
COPY creds.txt /root/creds.txt
RUN chmod +x /root/entry-point.sh
EXPOSE 22
ENTRYPOINT ["/root/entry-point.sh"]