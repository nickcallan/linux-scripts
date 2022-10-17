#!/bin/sh
sudo su root
github_base=https://github.com/nickcallan/linux-scripts/raw/main/factorio/

curl -sL "https://factorio.com/get-download/stable/headless/linux64" | tar xvJf - -C /opt

adduser --no-create-home factorio
chown -R factorio:factorio /opt/factorio

mkdir /opt/factorio/saves
curl -L ${github_base}estella_server.zip -o /opt/factorio/saves/estella_server.zip

curl -L ${github_base}server-settings.json -o /opt/factorio/data/server-settings.json

curl -L ${github_base}factorio.service -o /etc/systemd/system/factorio.service
systemctl --now enable factorio.service

# make sure to allow port 34197 UDP traffic!
