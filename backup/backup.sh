#!/bin/bash
#TODO: 
# 1. mkdir
# 2. cd
# 3. do something
# 4. delete older thing

DIR_PATH=$(cd "$(dirname "$0")"; pwd)

. $DIR_PATH/../env.sh

TODAY=b-`date +%Y-%m-%d`
FILE_SUF=tar.gz
TMP_BACKUP_DIRECTORY=$TODAY
TODAY_BACKUP_FILE=$TODAY.$FILE_SUF
BACKUP_FILE=$BACKUP_DIR/$TODAY_BACKUP_FILE
OLD_TMP_BACKUP_DIRECTORY=$BACKUP_DIR/b-`date -d '4 days ago' +%Y-%m-%d`.$FILE_SUF



if [ ! -d $BACKUP_DIR ];then
	mkdir $BACKUP_DIR
fi

mkdir $TMP_BACKUP_DIRECTORY
if [ $? -ne 0 ];then
	echo "build backup directory[$TMP_BACKUP_DIRECTORY] fail" 1>&2
	exit -1
fi 

cd $TMP_BACKUP_DIRECTORY
rsync -arLv $BACKUP_MEDIA_FILES .
if [ $? -ne 0 ];then
	echo "sync $BACKUP_MEDIA_FILES fail" 1>&2
	exit -1
fi
mysqldump -uwork -p12345678 check_app_production > db
if [ $? -ne 0 ];then
	echo "dump mysql fail" 1>&2
	exit -1
fi

cd ..
##TODO:error
tar zcf $TODAY_BACKUP_FILE $TMP_BACKUP_DIRECTORY/
mv $TODAY_BACKUP_FILE $BACKUP_FILE

rm -rf $TMP_BACKUP_DIRECTORY
echo $OLD_TMP_BACKUP_DIRECTORY
rm -rf $OLD_TMP_BACKUP_DIRECTORY
