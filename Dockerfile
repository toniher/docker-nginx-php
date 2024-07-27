FROM nginx:1.27

ARG COMPOSER_VERSION=2.7.7

RUN set -x; \
	apt-get update && apt-get -y upgrade;

RUN set -x; apt -y install lsb-release apt-transport-https ca-certificates wget
RUN set -x; wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg

RUN set -x; \
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN set -x; \
		apt-get update && apt-get -y upgrade;

RUN set -x; \
	apt-get install -y php8.3-fpm php8.3-gd php8.3-mysql php8.3-cli php8.3-common php8.3-curl php8.3-opcache php8.3-intl php8.3-mbstring php8.3-xml \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng-dev \
	libbz2-dev \
	libxslt-dev \
	libldap2-dev \
	imagemagick \
	curl \
	git \
	subversion \
	unzip \
	supervisor

RUN set -x; \
	rm -rf /var/lib/apt/lists/*

# Using www-data user
RUN sed -i 's/user  nginx/user  www-data/g' /etc/nginx/nginx.conf

# Setup the Composer installer
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
  && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
  && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }"

RUN php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} && rm -rf /tmp/composer-setup.php
