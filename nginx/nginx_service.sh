#!/bin/bash
DIR_PATH=$(cd "$(dirname "$0")"; pwd)

. $DIR_PATH/../env.sh


start_nginx()
{
	echo "start nginx ........."
	$NGINX_BIN -c $NGINX_CONF
}

stop_nginx()
{
	echo "stop nginx ..........."
	$NGINX_BIN -s stop
}


restart_nginx()
{
	echo "restart nginx ..............."
	stop_nginx
	sleep 2
	start_nginx
}

if [ "$1" == "start" ];then
	start_nginx
elif [ "$1" == "stop" ];then
	stop_nginx
elif [ "$1" == "restart" ];then
	restart_nginx
else
	echo "nginx_service.sh [stop|start|restart] "
fi

