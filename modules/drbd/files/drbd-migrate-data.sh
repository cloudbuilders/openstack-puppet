#!/bin/bash

# $1 = path to data
# $2 = service to potentially restart
function migrate_dir() {
    tmpdir=`mktemp -d`

    if [ "$2" != "" ]; then
	if ( /etc/init.d/$2 status > /dev/null 2>&1 ); then
	    touch ${tmpdir}/restart.service
	fi
    fi

    # move the actual data
    basename=`basename $1`

    if [ -d "$1" -a ! -d "/drbd/$basename" ]; then
	if [ -f ${tmpdir}/restart.service ]; then
	    /etc/init.d/$2 stop > /dev/null 2>&1
	fi

	# start moving the data
	cd `dirname $1`
	tar -cf - ${basename} | tar -C /drbd -xf -

	mv $1 $1.`date +%Y%m%d`
	ln -s /drbd/${basename} $1

	if [ -f ${tmpdir}/restart.service ]; then
	    /etc/init.d/$2 start > /dev/null 2>&1
	fi
    fi

    rm -rf ${tmpdir}
}

# Start moving the service data
migrate_dir /var/lib/mysql mysql
migrate_dir /var/lib/rabbitmq rabbitmq-server
migrate_dir /var/lib/glance glance-api
migrate_dir /var/lib/keystone keystone
