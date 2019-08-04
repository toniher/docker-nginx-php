FROM balenalib/rpi-raspbian:jessie

RUN set -x; \
	gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key CCD91D6111A06851 \
	&& gpg -a --export CCD91D6111A06851 | apt-key add - \
	&& echo "deb http://repozytorium.mati75.eu/raspbian jessie-backports main contrib non-free" > /etc/apt/sources.list.d/mati75.list

RUN set -x; \
	apt-get update && apt-get upgrade; \
	apt-get install -y php7.0 php7.0-fpm php7.0-gd php7.0-mysql php7.0-cli php7.0-common php7.0-curl php7.0-opcache php7.0-json php7.0-intl php7.0-mbstring php7.0-xml \
	nginx-full \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng12-dev \
	libbz2-dev \
	libxslt-dev \
	libldap2-dev \
	imagemagick \
	curl \
	git \
	subversion \
	unzip \
	wget \
	supervisor

RUN set -x; \
	rm -rf /var/lib/apt/lists/*

# Using www-data user
# RUN sed -i 's/user  nginx/user  www-data/g' /etc/nginx/nginx.conf

# Setup the Composer installer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"

RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=1.2.0 && rm -rf /tmp/composer-setup.php

# Below extracted from nginx Dockerfile
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]

