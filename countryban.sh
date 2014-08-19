#!/bin/bash
IPT=iptables
WORKDIR="/root/.iptables_rules" #herhangi bir dizin de olur fakat benim önerim bu
ISO="cn" #engellenmek istenen ülkenin iki harfli ISO kodu  
BLOCKDB="$ISO.zone"   
function iptables_reset {  
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
if [ -f $ISO.zone ]; then 
  IPS=$(grep -Ev "^#" $BLOCKDB)
  for i in $IPS
  do
    iptables -A INPUT -s $i -j DROP   #Giriş
    iptables -A OUTPUT -d $i -j DROP  #Çıkış 
  done
  fi
rm $WORKDIR/$SO.zone
