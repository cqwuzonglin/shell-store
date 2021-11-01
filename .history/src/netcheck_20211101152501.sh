#!/bin/sh

desc=www.baidu.com
ping_time_out=3
ping_error_count=0
ping_ok_count=0
check_flag=5

ping_check(){
  if ping -c 1  -W $ping_time_out  $desc >/dev/null ; then        
    ping_error_count=0
    let ping_ok_count=$ping_ok_count+1
    if [ $ping_ok_count -ge $check_flag ];then
      exit 0
    fi
    sleep 1
    continue
  else
    ping_ok_count=0
    let ping_error_count=$ping_error_count+1
    if [ $ping_error_count -ge $check_flag  ];then
      reboot
    fi
    sleep 1
  fi
}

while true;
do
  ping_check
done
