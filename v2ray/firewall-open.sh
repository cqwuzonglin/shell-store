#!/bin/bash
if [ "$1" ]; then
	for arg in $*
	do
	  echo "firewall-cmd --zone=public --add-port=$arg/tcp --permanent"
	  echo "firewall-cmd --zone=public --add-port=$arg/udp --permanent"
	  firewall-cmd --zone=public --add-port=$arg/tcp --permanent
	  firewall-cmd --zone=public --add-port=$arg/udp --permanent
	done
	firewall-cmd --reload
	firewall-cmd --zone=public --list-ports
else
	echo "one more port number request!"
fi

