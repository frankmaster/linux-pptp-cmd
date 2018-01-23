#!/bin/bash
source ./pptp-config.sh

echo -e "============================================================================================================\n"
echo "start vpn server: $vpnServer  name: $vpnName"
echo -e "\n============================================================================================================"
echo "--------------------------------------------"
#sudo cp ./chap-secrets /etc/ppp/chap-secrets
sudo pptpsetup --create $vpnName --server $vpnServer  --username $user --password $pass --encrypt --start
#sudo pon myvpn
echo 'ip route default ppp0'
sudo route del default
sudo ip route add default dev ppp0
echo 'update dns'
sudo cp ./googledns.conf  /etc/resolv.conf
echo "--------------------------------------------"
#curl ip.cn
ping -c 4 www.google.com
echo "============================================================================================================"
