# ip.txt用来保存IP地址，如果IP地址没有发生变化，则不进行地址更新，重复提交地址更新官方会封号。
iptxt="/userdisk/ddns/ip.txt"

# 获取IPv4地址
# ip=$(ip -4 addr show dev pppoe-wan | grep 'scope global' | grep -v deprecated | awk -F '/|inet ' 'NR==1{print $2;}' | awk -F '/|peer ' 'NR==1{print $1;}' 2>&1)
ip=$(curl -s http://www.meibu.com/ips.asp)
if [ "${ip:-none}" == "none" ] ; then
  echo "[ddns] 获取IP错误！"
  exit 12
fi

if [ -f $iptxt ] ; then
  oldip=$(tail -n 1 $iptxt)
else
  oldip="::"
fi
domain="wzlrouter.x3322.net"
pingIp=$(ping $domain -c 1 | awk 'NR==2 {print $4}' | sed -n 's/\([0-9\.]*\):/\1/p')
# 与ip.txt中的IP地址对比，如果一致，则退出；如果不一致，则将新IP写入ip.txt文件中，并提交动态域名更新。
if [ "$ip" = "$oldip" ] && [ "$ip" = "$pingIp" ] ; then
  echo "[ddns] IP无变化！"
else
  # 将变化的ip地址写入ip.txt
  echo "$oldip - $ip - $pingIp "
  echo $ip >$iptxt

  # 更新动态域名IP地址，xxxxxx.noip.cn为申请的域名，“pwd=”后面为密码
  url="http://members.3322.net/dyndns/update?system=dyndns&hostname=${domain}"
  re=$(curl -s -u wzlrouter:9D6At7YxyxtK3 $url)
  echo "[${ip}] ${re}！"
fi
