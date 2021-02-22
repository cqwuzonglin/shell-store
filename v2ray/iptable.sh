#!/bin/bash
if [ "$1" ]; then
	for arg in $*
	do
	  echo "firewall-cmd --zone=public --add-port=$arg/tcp --permanent"
	  firewall-cmd --zone=public --add-port=$arg/tcp --permanent
	done
else
	echo "one more port number request!"
fi

