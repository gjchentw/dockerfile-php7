FROM gjchen/php7

RUN	apt-get update -y && apt-get dist-upgrade -y && \
	mkdir -p /app/public && mv /app/index.php /app/public

ENV	NGINX_SERVER_TPL="/etc/nginx/conf.d/laravel.template"

EXPOSE	80

