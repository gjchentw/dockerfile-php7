FROM gjchen/alpine:latest
MAINTAINER gjchen <gjchen.tw@gmail.com>

RUN 	echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add nginx php7 php7-fpm

RUN	echo 'pid /var/run/nginx.pid;' > /etc/nginx/modules/pid.conf && \
	ln -s /usr/bin/php7 /usr/bin/php
ADD	nginx_default_server.conf /etc/nginx/conf.d/default.conf
ADD	php-fpm-www.conf /etc/php7/php-fpm.d/www-override.conf
ADD	php-cli.ini /etc/php7/php-cli.ini
ADD	index.php /app/index.php

ENV	PHP_ERROR_LOG=syslog
ENV	PHP_LOG_ERRORS=1
ENV	PHP_DISPLAY_ERRORS=1
ENV	PHP_ERROR_REPORTING=-1
ENV	PHP_TIMEZONE="Asia/Taipei"
ENV	PHP_OPEN_SHORT_TAG=0
ENV	PHP_MAX_EXECUTION_TIME=30
ENV	PHP_MAX_INPUT_TIME=60
ENV	PHP_MEMORY_LIMIT=128M
ENV	PHP_CLI_MEMORY_LIMIT=512M
ENV	PHP_POST_MAX_SIZE=8M
ENV	PHP_UPLOAD_MAX_FILESIZE=2M
ENV	PHP_SESSION_NAME=PHPSESSID
ENV	PHP_SESSION_SAVE_HANDLER=files
ENV	PHP_SESSION_SAVE_PATH=/tmp

ENV	PHPFPM_LISTEN=127.0.0.1:9000
ENV	PHPFPM_USER=nobody
ENV	PHPFPM_GROUP=nobody
ENV	PHPFPM_PM=ondemand
ENV	PHPFPM_PM_MAX_CHILDREN=32
ENV	PHPFPM_PM_START_SERVERS=4
ENV	PHPFPM_PM_MIN_SPARE_SERVERS=2
ENV	PHPFPM_PM_MAX_SPARE_SERVERS=6
ENV	PHPFPM_PM_MAX_REQUESTS=16

ENV	SYSLOG_ENABLED=0
ENV	CRON_ENABLED=0

VOLUME	["/app"]

CMD	test 0${SYSLOG_ENABLED} -ne 0 && rsyslogd; test 0${CRON_ENABLED} -ne 0 && crond -b; php-fpm7; nginx -g "daemon off;";
