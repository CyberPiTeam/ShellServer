#!/bin/bash
service ssh start
service nginx start
cd /app/wetty
npm start
sleep infinity
