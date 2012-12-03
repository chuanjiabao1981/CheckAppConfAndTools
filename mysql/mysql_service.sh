DATA_DIR=/home/work/mysql_data/

start_mysql()
{
	echo "Starting Mysql..\n"
	sudo mysqld_safe --datadir=$DATA_DIR  &
}

stop_mysql()
{
	echo 'Stoppping Mysql..\n'
	sudo mysqladmin -u root -p shutdown
}

restart_mysql()
{
	echo 'Restarting Mysql..\n'
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
