FROM	gjchen/php7:latest
MAINTAINER gjchen <gjchen.tw@gmail.com>

RUN 	echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
	apk --no-cache --no-progress upgrade -f && \
	apk --no-cache --no-progress add nginx curl && \
	mkdir -p /etc/nginx/server.d

ADD	nginx-main.conf /etc/nginx/modules/main.conf
ADD	nginx-http.conf	/etc/nginx/conf.d/00-http.conf
ADD	https://raw.githubusercontent.com/lukas2511/dehydrated/v0.3.1/dehydrated /etc/ssl/

ENV     SYSLOG_ENABLED=1
ENV     CRON_ENABLED=1
ENV     POSTFIX_ENABLED=1

# support Lets Encrypt, renew automatically if CRON_ENABLED=1
RUN	cd /etc/ssl && \
	mkdir .acme-challenges certs.d && \
	wget -O - https://letsencrypt.org/certs/isrgrootx1.pem https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem https://letsencrypt.org/certs/letsencryptauthorityx1.pem https://www.identrust.com/certificates/trustid/root-download-x3.html | tee -a letsencrypt-ca-certs.pem && \
	openssl dhparam -out dh2048.pem 2048 && \
	chmod a+x dehydrated && \
	printf "WELLKNOWN=/etc/ssl/.acme-challenges\nCERTDIR=/etc/ssl/certs.d\n" > config && \
	echo '0 0 * * * sleep $(expr $(printf "%d" "0x$(hostname | md5sum | cut -c 1-8)") % 86400);/etc/ssl/dehydrated -c --ocsp; nginx -s reload' >> /etc/crontabs/root

VOLUME	[ "/app", "/etc/nginx/server.d", "/etc/ssl/certs.d", "/etc/ssl/.acme-challenges" ]

EXPOSE	80 443

CMD	test 0${SYSLOG_ENABLED} -ne 0 && rsyslogd; test 0${CRON_ENABLED} -ne 0 && crond -b; test 0${POSTFIX_ENABLED} -ne 0 && postfix start; php-fpm.sh; nginx -g "daemon off;";
