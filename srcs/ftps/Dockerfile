FROM alpine
ARG IP

# We install packages
VOLUME /sys/fs/cgroup 
RUN apk update
RUN apk add openrc --no-cache
RUN apk add openssl
RUN apk add vsftpd
#RUN rc-update add vsftpd default


RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# We create SSH user and SSL key
RUN adduser -D user
RUN echo "user:password"|chpasswd
RUN yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.crt

# Telegraf setup
RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY ./vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN echo ${IP} > ip.txt
# RUN echo ${IP} >> /etc/vsftpd/vsftpd.conf

# Here we go
COPY start.sh ./start.sh
RUN chmod +x /start.sh
RUN mkdir /var/upload
RUN chmod 757 -R /var/upload
EXPOSE 21 30021 30020

CMD sh ./start.sh