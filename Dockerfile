FROM gjchen/php7:base
MAINTAINER gjchen <gjchen.tw@gmail.com>

RUN 	apk --no-cache --no-progress upgrade -f 
RUN	apk -v --no-cache --no-progress add postfix \
	php7-bcmath \
	php7-bz2 \
	php7-calendar \
	php7-ctype \
	php7-curl \
	php7-dba \
	php7-dom \
	php7-exif \
	php7-ftp \
	php7-iconv \
	php7-json \
	php7-mbstring \
	php7-mcrypt \
#	php7-memcached@testing \
	php7-mysqli \
	php7-openssl \
	php7-pcntl \
	php7-pdo \
	php7-pdo_odbc \
	php7-pdo_mysql \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-pear \
	php7-phar \
	php7-posix \
	php7-pspell \
	php7-shmop \
	php7-snmp \
	php7-soap \
	php7-sockets \
	php7-sysvmsg \
	php7-sysvsem \
	php7-sysvshm \
	php7-wddx \
	php7-xml \
	php7-xmlreader \
	php7-opcache \
	php7-zip \
	php7-zlib \
	php7-gd \
	php7-gmp \
	php7-intl \
	php7-imap \
	php7-ldap

RUN	postconf "smtputf8_enable=no"
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

ENV	PHPFPM_LSITEN=127.0.0.1:9000
ENV	PHPFPM_USER=nobody
ENV	PHPFPM_GROUP=nobody
ENV	PHPFPM_PM=ondemand
ENV	PHPFPM_PM_MAX_CHILDREN=32
ENV	PHPFPM_PM_START_SERVERS=4
ENV	PHPFPM_PM_MIN_SPARE_SERVERS=2
ENV	PHPFPM_PM_MAX_SPARE_SERVERS=6
ENV	PHPFPM_PM_MAX_REQUESTS=16

VOLUME	["/app"]

CMD	rsyslogd; crond -b; postfix start; php-fpm7; nginx -g "daemon off;";
