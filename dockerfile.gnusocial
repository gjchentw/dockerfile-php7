FROM gjchen/php7

RUN	apt-get update -y && apt-get dist-upgrade -y && \
	apt-get -y autoremove && apt-get -y autoclean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	mkdir -p /var/spool/postfix/etc && \
	echo nameserver 8.8.8.8 > /var/spool/postfix/etc/resolv.conf

COPY	s6.d.postfix /etc/s6.d

EXPOSE	80

