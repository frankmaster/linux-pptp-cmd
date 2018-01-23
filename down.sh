#!/bin/bash
source ./pptp-config.sh

pptpdExit=`ps -aux | grep pppd | head -n 1 | awk '{print $14}'` 

if [  "$vpnServer" == "$pptpdExit" ]; then
 echo "close vpn: $vpnName"
 sudo poff $vpnName
else
 echo "No pptpd running..."	
fi	

if [ -f /etc/ppp/peers/$vpnName ]; then
  echo "sudo pptpsetup --delete $vpnName"
  sudo pptpsetup --delete $vpnName
fi

#sudo cp ./chap-secrets /etc/ppp/chap-secrets
#sudo route del default

echo 'reset ip route default, networking restart'
sudo ip route add default via $defaultRoute
sudo /etc/init.d/networking restart

#sudo hamachi logoff
#sleep 1
#sudo hamachi logon
echo "All reset... Ok."
