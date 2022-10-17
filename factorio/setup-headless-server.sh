#!/bin/sh
sudo su root
github_base=https://github.com/nickcallan/linux-scripts/raw/main/factorio/

curl -sL "https://factorio.com/get-download/stable/headless/linux64" | tar xvJf - -C /opt

# make this dir before changing ownership, otherwise saves dir cannot be written to by factorio user
mkdir /opt/factorio/saves
adduser --no-create-home factorio
chown -R factorio:factorio /opt/factorio

curl -L ${github_base}estella_server.zip -o /opt/factorio/saves/estella_server.zip
curl -L ${github_base}server-settings.json -o /opt/factorio/data/server-settings.json

# make sure to allow port 34197 UDP traffic!
firewall-cmd --permanent --zone=public --add-port=34197/udp
systemctl restart firewalld

curl -L ${github_base}factorio.service -o /etc/systemd/system/factorio.service
systemctl --now enable factorio.service
