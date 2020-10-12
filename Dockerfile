FROM node:latest

WORKDIR /app

COPY . /app

#set up ssh and wetty
RUN apt-get update && apt-get install -y net-tools && apt-get install -y openssh-server && apt-get install -y curl && apt-get install -y nginx 

COPY shellserver.conf /etc/nginx/conf.d/

#RUN apt-get install sudo

#call challenge creation scripts

RUN node setupchals.js

RUN ./setupwetty.sh

RUN chmod o-rwx /app

EXPOSE 22

EXPOSE 80

CMD ["./run.sh"]
