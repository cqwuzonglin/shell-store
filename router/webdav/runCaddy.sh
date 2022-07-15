#!/bin/sh
isRun=$(ps | grep caddy | grep run | wc -l)
if [ "$isRun" = "0" ] ; then
  cd /userdisk/webdav/;
  ./caddy start;
fi
pid=$(ps | grep caddy | grep run | awk -F ' ' '{print $1}')
if [ $pid -lt 10000 ] ; then
  cd /userdisk/webdav/;
  ./caddy stop;
  ./caddy start;
fi
staus=$(curl --connect-timeout 2 -o /dev/null -s -w %{http_code} http://192.168.31.1:61022/)
if [ "${staus}" == "000" ] ; then
  cd /userdisk/webdav/;
  ./caddy stop;
  ./caddy start;
fi
