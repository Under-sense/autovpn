#!/bin/bash
if [[ "$EUID" -eq "0" ]]
then
else
echo "You must be root to run this."
exit 0
fi
apt update
apt install dirmngr apt-transport-https -y
apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
sh -c "echo 'deb https://repo.windscribe.com/debian buster main' > /etc/apt/sources.list.d/windscribe-repo.list"
apt update
apt install windscribe-cli -y
/etc/init.d/windscribe-cli start
windscribe login
windscribe connect
echo "echo \"You're ip\"
curl 2ip.ru" >> ~/.bashrc
systemctl daemon-reload
systemctl enable windscribe-cli.service
echo "Windscribe is installed."
exit 0
