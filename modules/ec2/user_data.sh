#!/bin/bash
apt update -y
apt install -y curl gnupg2

# Install pgAdmin 4 (web mode)
curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | gpg --dearmor > /usr/share/keyrings/pgadmin-keyring.gpg
sh -c 'echo "deb [signed-by=/usr/share/keyrings/pgadmin-keyring.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/jammy pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list'

apt update -y
apt install -y pgadmin4-web

# Configure pgAdmin
echo "pgadmin4 pgadmin4/webserver string apache2" | debconf-set-selections
/usr/pgadmin4/bin/setup-web.sh --yes

# Allow port 5050 for pgAdmin (default web port)
ufw allow 5050
