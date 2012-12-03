. ../env.sh
##创建用户组
groupadd checkapp
##添加用户
adduser $CHECKAPP_USER
##加入组
adduser $CHECKAPP_USER admin
adduser $CHECKAPP_USER checkapp
#把 admin组加入sudo权限
rm $CHECKAPP_SUDO_FILE
echo "$CHECKAPP_USER	ALL=(ALL:ALL) ALL" > $CHECKAPP_SUDO_FILE
chmod 0440 $CHECKAPP_SUDO_FILE
su - work

