FROM	gjchen/debian:stretch

ARG	PHP=7.2
ENV	TZ="Asia/Taipei" \
	APP="/app" \
	NGINX_SERVER_TPL="/etc/nginx/conf.d/default.template" \
	PHPFPM_DISABLE_EXT="snmp" \
	PHP_ERROR_LOG=syslog \
	PHP_LOG_ERRORS=1 \
	PHP_DISPLAY_ERRORS=1 \
	PHP_ERROR_REPORTING=-1 \
	PHP_SHORT_OPEN_TAG=0 \
	PHP_MAX_EXECUTION_TIME=300 \
	PHP_MAX_INPUT_TIME=300 \
	PHP_MEMORY_LIMIT=1024M \
	PHP_CLI_MEMORY_LIMIT=1024M \
	PHP_POST_MAX_SIZE=512M \
	PHP_UPLOAD_MAX_FILESIZE=512M \
	PHP_SESSION_NAME=PHPSESSID \
	PHP_SESSION_SAVE_HANDLER=files \
	PHP_SESSION_SAVE_PATH=/tmp \
	PHPFPM_LISTEN=127.0.0.1:9000 \
	PHPFPM_USER=nobody \
	PHPFPM_GROUP=nogroup \
	PHPFPM_PM=ondemand \
	PHPFPM_PM_MAX_CHILDREN=32 \
	PHPFPM_PM_START_SERVERS=4 \
	PHPFPM_PM_MIN_SPARE_SERVERS=2 \
	PHPFPM_PM_MAX_SPARE_SERVERS=6 \
	PHPFPM_PM_MAX_REQUESTS=16

RUN	apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/debian/ stretch nginx" > /etc/apt/sources.list.d/nginx.list && \
	wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && \
	echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list && \
	apt-get update -y && apt-get dist-upgrade -y && \
	apt-get install --no-install-recommends --no-install-suggests -y \
	gettext-base nginx php${PHP}-cli $(apt-cache search php | grep ^php${PHP}- | grep -v dbgsym | grep -v php${PHP}-dev| awk '{print $1}' | xargs echo) && \
	apt-get -y autoremove && apt-get -y autoclean && \
	wget -q -O- https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin && \
	mkdir -p /.composer && chmod 777 /.composer && \
	mkdir -p /run/php/ && chmod 777 /run/php/ && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	echo '*.*       |/dev/stdout' > /etc/rsyslog.d/50-default.conf

COPY	index.php /app/index.php
COPY	nginx /etc/nginx/conf.d/
COPY	php-cli.ini /etc/php/${PHP}/cli/conf.d/00-cli.ini
COPY	php-fpm-www.conf /etc/php/${PHP}/fpm/php-fpm-www.conf
COPY	s6.d /etc/s6.d

	

EXPOSE	80
