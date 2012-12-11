#!/bin/bash
DIR_PATH=$(cd "$(dirname "$0")"; pwd)
echo `pwd`
echo $DIR_PATH
. $DIR_PATH/../env.sh

if [ ! -d $BACKUP_LOG_DIR ];then
	mkdir $BACKUP_LOG_DIR
fi
#标准输出太多所以不能追加
$DIR_PATH/backup.sh 1>$BACKUP_LOG_DIR/back_up.log 2>>$BACKUP_LOG_DIR/back_up.err
