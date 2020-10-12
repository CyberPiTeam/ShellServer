#!/bin/bash
service ssh start
service nginx start
cd /app/wetty
npm start &
cd /app/registrationapp
npm start
