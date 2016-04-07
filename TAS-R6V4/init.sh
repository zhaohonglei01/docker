#!/bin/bash

/etc/init.d/mysql start

mysql -e "create database tctas;"
mysql -e "create user tasadm identified by 'tasadm';"
mysql -e "grant all on *.* to 'tasadm'@'%' identified by 'tasadm';"
mysql -e "grant all on *.* to 'tasadm'@'localhost' identified by 'tasadm';"

echo "Init tas"
. ~/tashome/tasrtenv.sh
taspatch.sh
tasdbinit.sh
echo "Init tas done"

