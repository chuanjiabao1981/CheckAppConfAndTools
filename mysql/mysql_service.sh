#!/bin/bash
DIR_PATH=$(cd "$(dirname "$0")"; pwd)

. $DIR_PATH/../env.sh
start_mysql()
{
	echo "Starting Mysql.."
	sudo mysqld_safe --datadir=$DATA_DIR  &
}

stop_mysql()
{
	echo "Stoppping Mysql.."
	sudo mysqladmin -u root -p shutdown
}

restart_mysql()
{
	echo "Restarting Mysql.."
	stop_mysql
	sleep 5
	start_mysql
}

if [ "$1" == "start" ];then
	start_mysql
elif [ "$1" == "stop" ];then
	stop_mysql
elif [ "$1" == "restart" ];then
	restart_mysql
else 
	echo "mysql_service.sh [start|stop|restart]"
fi
