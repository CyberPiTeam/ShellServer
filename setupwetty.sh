#!/bin/bash
git clone https://github.com/butlerx/wetty.git
#useradd -m wetty
#chown -R wetty:wetty wetty
#chmod o+rwx wetty
cd wetty
npm install
npm run build
