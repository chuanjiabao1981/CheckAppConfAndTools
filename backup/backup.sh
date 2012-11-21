#TODO: 
# 1. mkdir
# 2. cd
# 3. do something
# 4. delete older thing
BACKUP_DIRECTORY=b-`date +%Y-%m-%d`
BACKUP_MEDIA_FILES="../../current/public/report_media"
OLD_BACKUP_DIRECTORY=b-`date -d '4 days ago' +%Y-%m-%d`

mkdir $BACKUP_DIRECTORY
if [ $? -ne 0 ];then
	echo "build backup directory[$BACKUP_DIRECTORY] fail" 1>&2
	exit -1
fi 

cd $BACKUP_DIRECTORY
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
tar zcf $BACKUP_DIRECTORY.tar.gz $BACKUP_DIRECTORY/

rm -rf $BACKUP_DIRECTORY
echo $OLD_BACKUP_DIRECTORY
rm -rf $OLD_BACKUP_DIRECTORY
