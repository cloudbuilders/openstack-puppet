#!/bin/bash

# move the mysql data
if [ -d /var/lib/mysql -a ! -d /drbd/mysql ]; then
    rm -f /tmp/restart.mysql 

    if [ `ps auxw | grep [m]ysql | wc -l` -gt 0 ]; then
	/etc/init.d/mysql stop
	touch /tmp/restart.mysql
    fi

    cd /var/lib
    tar -cf - mysql | tar -C /drbd -xf -
    mv /var/lib/mysql /var/lib/mysql.old
    ln -s /drbd/mysql /var/lib/mysql

    if [ -f /tmp/restart.mysql ]; then
	/etc/init.d/mysql start
	rm -f /tmp/restart.mysql
    fi
fi

if [ -d /var/lib/mysql -a ! -L /var/lib/mysql ]; then
    mv /var/lib/mysql /var/lib/mysql.`date +%Ymd`
    ln -s /drbd/mysql /var/lib/mysql
fi

if [ ! -d /drbd/mysql ]; then
    mkdir /drbd/mysql
fi


# move the rabbit data
if [ -d /var/lib/rabbitmq -a ! -d /drbd/rabbitmq ]; then
    rm -f /tmp/restart.rabbitmq 

    if [ `ps auxw | grep [r]abbit | wc -l` -gt 0 ]; then
	/etc/init.d/rabbitmq-server stop
	touch /tmp/restart.rabbitmq
    fi

    cd /var/lib
    tar -cf - rabbitmq | tar -C /drbd -xf -
    mv /var/lib/rabbitmq /var/lib/rabbitmq.old
    ln -s /drbd/rabbitmq /var/lib/rabbitmq

    if [ -f /tmp/restart.rabbitmq ]; then
	/etc/init.d/rabbitmq-server start
	rm -f /tmp/restart.rabbitmq
    fi
fi

if [ -d /var/lib/rabbitmq -a ! -L /var/lib/rabbitmq ]; then
    mv /var/lib/rabbitmq /var/lib/rabbitmq.`date +%Ymd`
    ln -s /drbd/rabbitmq /var/lib/rabbitmq
fi

if [ ! -d /drbd/rabbitmq ]; then
    mkdir /drbd/rabbitmq
fi
