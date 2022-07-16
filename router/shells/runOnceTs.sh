uptime=$(expr `date +%s` - `cut -f1 -d. /proc/uptime`)
runtime=$(cat /userdisk/runtime)
echo "uptime:$uptime runtime:$runtime"
if [ "$runtime" -gt "$uptime" ]; then
  echo 'not first run'
else
  echo 'first run'
  date "+%s" > /userdisk/runtime
  iptables -t nat -A zone_lan_postrouting -s 192.168.31.0/24 -d 192.168.31.1/32 -p tcp -m tcp --dport 61022 -m comment --comment "redirect (reflection)" -j SNAT --to-source 192.168.31.1
  iptables -t nat -A zone_lan_prerouting -s 192.168.31.0/24 -d 192.168.5.100/32 -p tcp -m tcp --dport 61022 -m comment --comment "redirect (reflection)" -j DNAT --to-destination 192.168.31.1:61022
  iptables -t nat -A zone_wan_prerouting -p tcp -m tcp --dport 61022 -m comment --comment "redirect" -j DNAT --to-destination 192.168.31.1:61022
  iptables-save
fi

