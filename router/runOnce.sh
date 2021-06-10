#!/bin/sh
uptime=$(expr `date +%s` - `cut -f1 -d. /proc/uptime`)
runtime=$(cat /userdisk/runtime)
echo "uptime:$uptime runtime:$runtime"
if [ "$runtime" -gt "$uptime" ]; then
  echo 'not run'
else
  IP_ADDR=$(ip -4 addr show dev pppoe-wan | grep 'scope global' | grep -v deprecated | awk -F '/|inet ' 'NR==1{print $2;}'| awk -F '/|peer ' 'NR==1{print $1;}' 2>&1)
  if [ -n "$IP_ADDR" ]; then
    date +%s > /userdisk/runtime
    echo 'must run'
    iptables -t nat -A zone_lan_postrouting -s 192.168.31.0/24 -d 192.168.31.1/32 -p tcp -m tcp --dport 60000:64000 -m comment --comment "redirect (reflection)" -j SNAT --to-source 192.168.31.1
    iptables -t nat -A zone_lan_prerouting -s 192.168.31.0/24 -d "$IP_ADDR"/32 -p tcp -m tcp --dport 60000:64000 -m comment --comment "redirect (reflection)" -j DNAT --to-destination 192.168.31.1:60000-64000
    iptables -t nat -A zone_wan_prerouting -p tcp -m tcp --dport 60000:64000 -m comment --comment "redirect" -j DNAT --to-destination 192.168.31.1:60000-64000
    iptables-save
    nohup /userdisk/nps/npc &
    cd /userdisk/webdav/;
    ./caddy start
  fi

fi
