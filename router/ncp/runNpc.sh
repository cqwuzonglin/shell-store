#!/bin/sh
isRun=$(ps | grep npc | grep ./ | wc -l)
if [ "$isRun" = "0" ] ; then
  cd /userdisk/nps
  nohup ./npc & >/dev/null 2>&1
fi