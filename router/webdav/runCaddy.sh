#!/bin/sh
isRun=$(ps | grep caddy | grep run | wc -l)
if [ "$isRun" = "0" ] ; then
  cd /userdisk/webdav/;
  ./caddy start;
fi