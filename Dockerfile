FROM node:lts-buster

WORKDIR /app

COPY . /app

#Install tools for system
RUN apt-get update && apt-get install -y net-tools openssh-server curl nginx man-db git python3 netcat ssh nmap ftp dnsutils

#Install tools for users

RUN apt-get install -y vim tmux

COPY shellserver.conf /etc/nginx/conf.d/

#Harden host

RUN chmod 700 /usr/bin/wall

RUN echo 'EXTRA_GROUPS="users"' >> /etc/adduser.conf
#set users group blocks and inodes limit
#RUN setquota -g users 8192 8192 10000 10000 /

COPY limits.conf /etc/security/limits.conf

COPY motd /etc/motd

RUN echo 'umask 0066' >> /etc/bash.bashrc

RUN echo 'cat /etc/motd' >> /etc/bash.bashrc

#copy challenges over

RUN mkdir -p /usr/share/challenges

RUN cp -r /app/challenges /usr/share/

#setup wetty 
WORKDIR /app

RUN chmod +x ./setupwetty.sh

RUN chmod o-rwx /app

#setup registration app

RUN cp -r /app/frontend/* /var/www/html

WORKDIR /app/registrationapp

RUN npm install

WORKDIR /app

EXPOSE 22

EXPOSE 80

RUN chmod +x ./run.sh
