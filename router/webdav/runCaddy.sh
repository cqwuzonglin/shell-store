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
