#!/bin/sh
github_base=https://github.com/nickcallan/linux-scripts/raw/main/factorio/

sudo su root
curl -s "https://factorio.com/get-download/stable/headless/linux64" | tar xvz -C /opt

adduser --disabled-login --no-create-home --gecos factorio factorio
chown -R factorio:factorio /opt/factorio

mkdir /opt/factorio/saves
cd /opt/factorio/saves
curl -OL ${github_base}estella_server.zip

cd /opt/factorio/data
curl -OL ${github_base}server-settings.json

curl -L ${github_base}factorio.service -o /etc/systemd/system/factorio.service
systemctl --now enable factorio.service

# make sure to allow port 34197 UDP traffic!
