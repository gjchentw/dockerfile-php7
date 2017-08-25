FROM gjchen/alpine:edge
MAINTAINER gjchen <gjchen.tw@gmail.com>

ENV	PHP_ERROR_LOG=syslog
ENV	PHP_LOG_ERRORS=1
ENV	PHP_DISPLAY_ERRORS=1
# E_ALL & ~E_NOTICE & ~E_STRICT & ~E_DEPRECATED & ~E_WARNING
ENV	PHP_ERROR_REPORTING=22517
ENV	PHP_TIMEZONE="Asia/Taipei"
ENV	PHP_SHORT_OPEN_TAG=0
ENV	PHP_MAX_EXECUTION_TIME=30
ENV	PHP_MAX_INPUT_TIME=60
ENV	PHP_MEMORY_LIMIT=128M
ENV	PHP_CLI_MEMORY_LIMIT=512M
ENV	PHP_POST_MAX_SIZE=8M
ENV	PHP_UPLOAD_MAX_FILESIZE=2M
ENV	PHP_UPLOAD_TMP_DIR=/tmp
ENV	PHP_SESSION_NAME=PHPSESSID
ENV	PHP_SESSION_SAVE_HANDLER=files
ENV	PHP_SESSION_SAVE_PATH=/tmp
ENV	PHP_XDEBUG_HOST="172.17.0.1"

ENV	PHPFPM_LISTEN=127.0.0.1:9000
ENV	PHPFPM_USER=nobody
ENV	PHPFPM_GROUP=nobody
ENV	PHPFPM_PM=ondemand
ENV	PHPFPM_PM_MAX_CHILDREN=32
ENV	PHPFPM_PM_START_SERVERS=4
ENV	PHPFPM_PM_MIN_SPARE_SERVERS=2
ENV	PHPFPM_PM_MAX_SPARE_SERVERS=6
ENV	PHPFPM_PM_MAX_REQUESTS=16

RUN 	echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add nginx postfix geoip imagemagick libmemcached-libs \
	php7 php7-fpm php7-pear \
	php7 \
	php7-bcmath \
	php7-bz2 \
	php7-calendar \
	php7-cgi \
	php7-common \
	php7-ctype \
	php7-curl \
	php7-dba \
	php7-doc \
	php7-dom \
	php7-embed \
	php7-enchant \
	php7-exif \
	php7-ftp \
	php7-gd \
	php7-gettext \
	php7-gmp \
	php7-iconv \
	php7-imap \
	php7-intl \
	php7-json \
	php7-ldap \
	php7-litespeed \
	php7-mbstring \
	php7-mcrypt \
	php7-mysqli \
	php7-mysqlnd \
	php7-odbc \
	php7-opcache \
	php7-openssl \
	php7-pcntl \
	php7-pdo \
	php7-pdo_dblib \
	php7-pdo_mysql \
	php7-pdo_odbc \
	php7-pdo_pgsql \
	php7-pdo_sqlite \
	php7-pgsql \
	php7-phar \
	php7-phpdbg \
	php7-posix \
	php7-pspell \
#	php7-readline \
	php7-session \
	php7-shmop \
	php7-snmp \
	php7-soap \
	php7-sockets \
	php7-sqlite3 \
	php7-sysvmsg \
	php7-sysvsem \
	php7-sysvshm \
	php7-tidy \
	php7-wddx \
	php7-xml \
	php7-xmlreader \
	php7-xmlrpc \
	php7-xsl \
	php7-zip \
	php7-zlib \
	php7-memcached@testing

# cli ready for pecl tool
ADD	php-cli.ini /etc/php7/php-cli.ini

RUN	mv /etc/php7/conf.d /etc/php7/mods-available && \
	mkdir -p /etc/php7/conf.d && \
	ln -s /etc/php7/mods-available/00_xml.ini /etc/php7/conf.d/00-xml.ini && \
	apk --no-cache --no-progress add --virtual pecl-build-tools \
	php7-dev autoconf build-base \
	geoip-dev \
	zlib-dev \
	imagemagick-dev \
	libtool \
	openssl-dev \
	pcre-dev \
	libmemcached-dev \
	cyrus-sasl-dev \
	&& \
	pear config-set php_ini /etc/php7/mods-available/apcu.ini && \
	touch /etc/php7/mods-available/apcu.ini && \
	pear install http://pecl.php.net/get/apcu-5.1.7.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/apfd.ini && \
	touch /etc/php7/mods-available/apfd.ini && \
	pear install http://pecl.php.net/get/apfd-1.0.1.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/geoip.ini && \
	touch /etc/php7/mods-available/geoip.ini && \
	pear install http://pecl.php.net/get/geoip-1.1.1.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/raphf.ini && \
	touch /etc/php7/mods-available/raphf.ini && \
	pear install http://pecl.php.net/get/raphf-2.0.0.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/propro.ini && \
	touch /etc/php7/mods-available/propro.ini && \
	pear install http://pecl.php.net/get/propro-2.0.1.tar \
	&& \
	ln -s /etc/php7/mods-available/raphf.ini /etc/php7/conf.d/10-raphf.ini && \
	ln -s /etc/php7/mods-available/propro.ini /etc/php7/conf.d/10-propro.ini \
	&& \
	pear config-set php_ini /etc/php7/mods-available/http.ini && \
	touch /etc/php7/mods-available/http.ini && \
	pear install http://pecl.php.net/get/pecl_http-3.0.1.tar \
	&& \
#	pear config-set php_ini /etc/php7/mods-available/igbinary.ini && \
#	touch /etc/php7/mods-available/igbinary.ini && \
#	pear install http://pecl.php.net/get/igbinary-1.2.1.tar \
#	&& \
	pear config-set php_ini /etc/php7/mods-available/imagick.ini && \
	touch /etc/php7/mods-available/imagick.ini && \
	pear install http://pecl.php.net/get/imagick-3.4.3RC1.tar \
	&& \
#	pear config-set php_ini /etc/php7/mods-available/memcache.ini && \
#	touch /etc/php7/mods-available/memcache.ini && \
#	pear install http://pecl.php.net/get/memcache-3.0.8.tar \
#	&& \
#	pear config-set php_ini /etc/php7/mods-available/memcached.ini && \
#	touch /etc/php7/mods-available/memcached.ini && \
#	pear install http://pecl.php.net/get/memcached-2.2.0.tar \
#	&& \
	pear config-set php_ini /etc/php7/mods-available/mongo.ini && \
	touch /etc/php7/mods-available/mongo.ini && \
	pear install http://pecl.php.net/get/mongodb-1.1.9.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/msgpack.ini && \
	touch /etc/php7/mods-available/msgpack.ini && \
	pear install http://pecl.php.net/get/msgpack-2.0.1.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/OAuth.ini && \
	touch /etc/php7/mods-available/OAuth.ini && \
	pear install http://pecl.php.net/get/oauth-2.0.2.tar \
	&& \
	pear config-set php_ini /etc/php7/mods-available/xdebug.ini && \
	touch /etc/php7/mods-available/xdebug.ini && \
	pear install http://pecl.php.net/get/xdebug-2.5.0RC1.tar \
	&& \
	rm -rf /tmp/pear && \
	rm -f /etc/php7/conf.d/* && \	
	apk --no-progress --force del pecl-build-tools

RUN	echo xdebug.profiler_enable = On >> /etc/php7/mods-available/xdebug.ini && \
	echo xdebug.remote_enable = On >> /etc/php7/mods-available/xdebug.ini && \
	echo xdebug.remote_port = 9000 >> /etc/php7/mods-available/xdebug.ini && \
	echo xdebug.remote_handler = "dbgp" >> /etc/php7/mods-available/xdebug.ini

ENV	SYSLOG_ENABLED=0
ENV	CRON_ENABLED=0
ENV	POSTFIX_ENABLED=0
ENV	PHP_EXT_ENABLED="apcu apfd bcmath bz2 calendar ctype curl dba dom enchant exif ftp gd geoip gettext gmp http iconv imagick imap intl json ldap mbstring mcrypt memcached mongodb msgpack mysqli mysqlnd oauth odbc opcache openssl pcntl pdo pdo_dblib pdo_mysql pdo_odbc pdo_pgsql pdo_sqlite pgsql phar posix propro pspell raphf readline session shmop snmp soap sockets sqlite3 sysvmsg sysvsem sysvshm tidy wddx xdebug xml xmlreader xmlrpc xsl zip zlib"
ADD	nginx_default_server.conf /etc/nginx/conf.d/default.conf
ADD	php-fpm-www.conf /etc/php7/
ADD	php-fpm.sh /usr/local/bin
ADD	index.php /app/index.php
RUN	echo 'pid /var/run/nginx.pid;' > /etc/nginx/modules/pid.conf && \
	ln -s /usr/bin/php7 /usr/bin/php && \
	chmod a+x /usr/local/bin/php-fpm.sh


VOLUME	["/app"]

CMD	test 0${SYSLOG_ENABLED} -ne 0 && rsyslogd; test 0${CRON_ENABLED} -ne 0 && crond -b; test 0${POSTFIX_ENABLED} -ne 0 && postfix start; php-fpm.sh; nginx -g "daemon off;";


