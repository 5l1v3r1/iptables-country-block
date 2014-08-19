#!/bin/bash
IPT=iptables
WORKDIR="/root/.iptables_rules" #You can set workdir in another directory. 
ISO="cn" #two letters ISO code of country  
BLOCKDB="$ISO.zone"
IPS=$(grep -Ev "^#" $BLOCKDB) #Select ip (it will can change for another service)
function iptables_reset {  #Warning! : This function will Reset your iptables statement. 
#Please backup your iptables settings and write them  on "Another iptables commands".   
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
$IPT -P INPUT ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT
}
cd $WORKDIR
iptables_reset
wget www.ipdeny.com/ipblocks/data/countries/$ISO.zone 
#I use ipdeny.com service for this. If you find better one, you can use it. 
if [ -f $ISO.zone ]; then 
  for i in $IPS
  do
    iptables -A INPUT -s $i -j DROP   
    iptables -A OUTPUT -d $i -j DROP
    #Another iptables commands
  done
  fi
rm $WORKDIR/$SO.zone #remove zonefiles (for automatic crontab update)
