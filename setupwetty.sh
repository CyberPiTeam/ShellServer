#!/bin/bash
git clone --depth 1 --branch v1.4.1  https://github.com/butlerx/wetty.git
#useradd -m wetty
#chown -R wetty:wetty wetty
#chmod o+rwx wetty
cd wetty
npm install
npm run build
