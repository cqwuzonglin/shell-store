#!/bin/sh
uptime=$(expr `date +%s` - `cut -f1 -d. /proc/uptime`)
runtime=$(cat /userdisk/runtime)
echo "uptime:$uptime runtime:$runtime"
if [ "$runtime" -gt "$uptime" ]; then
  echo 'not run'
else
  date +%s > /userdisk/runtime
  echo 'must run'

  iptables -t nat -A zone_lan_postrouting -s 192.168.31.0/24 -d 192.168.31.1/32 -p tcp -m tcp --dport 60000:64000 -m comment --comment "redirect (reflection)" -j SNAT --to-source 192.168.31.1
  iptables -t nat  -A zone_lan_prerouting -s 192.168.31.0/24 -d 220.192.35.77/32 -p tcp -m tcp --dport 60000:64000 -m comment --comment "redirect (reflection)" -j DNAT --to-destination 192.168.31.1:60000-64000
  iptables -t nat  -A zone_wan_prerouting -p tcp -m tcp --dport 60000:64000 -m comment --comment "redirect" -j DNAT --to-destination 192.168.31.1:60000-64000
  iptables-save
  nohup /userdisk/nps/npc &
  /userdisk/webdav/caddy start

fi
