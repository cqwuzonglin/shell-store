# 取当前文件目录
dir=$(
  cd $(dirname $0)
  pwd
)

# ip.txt用来保存IP地址，如果IP地址没有发生变化，则不进行地址更新，重复提交地址更新官方会封号。
iptxt="$dir""/ip.txt"

# 获取IPv4地址
ip=$(ip -4 addr show dev pppoe-wan | grep 'scope global' | grep -v deprecated | awk -F '/|inet ' 'NR==1{print $2;}' | awk -F '/|peer ' 'NR==1{print $1;}' 2>&1)
if [ "${ip:-none}" == "none" ] ; then
  echo "[ddns] 获取IP错误！"
  exit 12
fi

if [ -f $iptxt ] ; then
  oldip=$(tail -n 1 $iptxt)
else
  oldip="::"
fi

pingIp=$(ping $domain -c 1 | awk 'NR==2 {print $5}' | sed -n 's/(\([0-9\.]*\)):/\1/p')
# 与ip.txt中的IP地址对比，如果一致，则退出；如果不一致，则将新IP写入ip.txt文件中，并提交动态域名更新。
if [ $ip = $oldip ] && [ $ip = $pingIp ] ; then
  echo "[ddns] IP无变化！"
else
  # 将变化的ip地址写入ip.txt
  echo $oldip - $ip - `[ "$ip" == "$oldip" ]`
  echo $ip >$iptxt

  # 更新动态域名IP地址，xxxxxx.noip.cn为申请的域名，“pwd=”后面为密码
  url="http://main.meibu.com/ip/login.asp?name=wzlrouter.noip.cn&pwd=252124779&ips=0"
  re=$(curl -s $url)
  echo "[${ip}] ${re}！"
fi


