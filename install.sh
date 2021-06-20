#!/bin/bash
if [[ "$EUID" -ne "0" ]]; then
	echo "You must be root to run this."
	exit 1
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
echo "Do you want to display IP when starting the terminal as root?: "
echo "[0] No"
echo "[1] Yes"
read doing
if [[ $doing -eq "1" ]]; then
	echo -e "echo \"You're ip\"\ncurl 2ip.ru" >> ~/.zshrc
	echo -e "echo \"You're ip\"\ncurl 2ip.ru" >> ~/.bashrc
fi
systemctl daemon-reload
systemctl enable windscribe-cli.service
clear
echo "Windscribe is installed."
exit 0
