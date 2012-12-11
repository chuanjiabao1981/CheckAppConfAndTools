CHECKAPP_USER=work
CHECKAPP_SUDO_FILE=/etc/sudoers.d/checkapp_$CHECKAPP_USER
CHECKAPP_MYSQL_CONF=/etc/mysql/conf.d/checkapp.cnf
DATA_DIR=/home/$CHECKAPP_USER/data/mysql_data/

NGINX_DIR=/opt/nginx/
NGINX_BIN=$NGINX_DIR/sbin/nginx
NGINX_CONF=$NGINX_DIR/conf/nginx.conf

BACKUP_DIR=/home/$CHECKAPP_USER/data/backup_data/
BACKUP_MEDIA_FILES=/home/$CHECKAPP_USER/application/current/public/report_media
BACKUP_LOG_DIR=$BACKUP_DIR/log
