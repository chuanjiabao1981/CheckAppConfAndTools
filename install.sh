CHECKAPP_USER=work
CHECKAPP_SUDO_FILE=/etc/sudoers.d/checkapp.$CHECKAPP_USER
CHECKAPP_MYSQL_CONF=/etc/mysql/conf.d/checkapp.cnf
DATA_DIR=/home/$CHECKAPP_USER/mysql_data/

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

##安转依赖的包
sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion imagemagick libmagickcore-dev libmagickwand-dev nodejs libcurl4-openssl-dev  libcurl4-gnutls-dev 

##安装rvm
curl -L get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 1.9.3 
#ruby1.9.3为默认
rvm --default use 1.9.3

rvm gemset use global
gem install bundler

##安装rails
gem install rails -v 3.2.1

##安装nginx 和 passagen
gem install passenger
rvmsudo env PATH=$PATH passenger-install-nginx-module
###不加这个看看什么效果
#rvm wrapper 1.9.3@global passenger

##安装mysql
sudo apt-get install mysql-server mysql-client libmysql-ruby libmysqlclient-dev
gem install mysql2 
gem install activerecord-mysql2-adapter

sudo rm $CHECKAPP_MYSQL_CONF
sudo sh -c "cat > $CHECKAPP_MYSQL_CONF << EOF
[client]
default-character-set	=	utf8
[mysqld]
character_set_server 	= 	utf8
init_connect 		= 	'SET NAMES utf8'
EOF"
#创建新库
sudo mysql_install_db --user=mysql --datadir=$DATA_DIR
#修改root密码
mysql_secure_installation
#建新表
mysql -u root -p -e'CREATE DATABASE check_app_production'
#用户授权
mysql -u root -p -e"GRANT ALL PRIVILEGES ON check_app_production.* TO '$CHECKAPP_USER'@'localhost' IDENTIFIED BY '12345678';"


#下载应用程序
cd ~
mkdir application
cd application
git clone git://github.com/chuanjiabao1981/CheckApp.git
ln -s CheckApp current
cd current
bundle install
