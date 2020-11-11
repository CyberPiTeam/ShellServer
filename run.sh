#!/bin/bash
echo "nameserver 10.30.0.1" > /etc/resolv.conf
service ssh start
service nginx start
cd /app/wetty
npm start &
cd /app/registrationapp
npm start
