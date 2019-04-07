#!/bin/sh

if [ ! -e /data/murmur.ini ]; then
	echo Starting Initialization
	cp /etc/murmur.tpl /data/murmur.ini
	if [ ! -z "$SERVER_PASSWORD" ] ; then echo 'serverpassword='"$SERVER_PASSWORD" >> /data/murmur.ini ; fi
	if [ ! -z "$MAX_USERS" ] ; then echo 'users='"$MAX_USERS" >> /data/murmur.ini ; fi
	if [ ! -z "$SERVER_TEXT" ] ; then echo 'welcometext='"$SERVER_TEXT" >> /data/murmur.ini ; fi
	if [ ! -z "$REGISTER_NAME" ] ; then echo 'registerName='"$REGISTER_NAME" >> /data/murmur.ini ; fi
	if [ ! -z "$BANDWIDTH" ] ; then echo 'bandwidth='"$BANDWIDTH" >> /data/murmur.ini ; fi
	if [ ! -z "$SUPW" ] ; then /usr/bin/murmurd -fg -ini /data/murmur.ini -supw $SUPW ;fi
	if [ ! -z "$SSL_CERT" ] ; then echo 'sslCert='"$SSL_CERT" >> /data/murmur.ini ; fi
	if [ ! -z "$SSL_KEY" ] ; then echo 'sslKey='"$SSL_KEY" >> /data/murmur.ini ; fi
	if [ ! -z "$SSL_CA" ] ; then echo 'sslCA='"$SSL_CA" >> /data/murmur.ini ; fi
	if [ ! -z "$MYSQL_DATABASE" ] ; then
		echo 'dbDriver=QMYSQL' >> /data/murmur.ini
		if [ ! -z "$MYSQL_DATABASE" ] ; then echo 'database='"$MYSQL_DATABASE" >> /data/murmur.ini ; fi
		if [ ! -z "$MYSQL_HOST" ] ; then echo 'dbHost='"$MYSQL_HOST" >> /data/murmur.ini ; fi
		if [ ! -z "$MYSQL_USER" ] ; then echo 'dbUsername='"$MYSQL_USER" >> /data/murmur.ini ; fi
		if [ ! -z "$MYSQL_PASSWORD" ] ; then echo 'dbPassword='"$MYSQL_PASSWORD" >> /data/murmur.ini ; fi
	else
		echo 'database=/data/db.sqlite' >> /data/murmur.ini
	fi
	echo Initilization Completed 
fi

exec /usr/bin/murmurd -fg -ini /data/murmur.ini
