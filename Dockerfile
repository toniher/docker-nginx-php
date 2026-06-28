FROM nginx:1.30

RUN set -x; \
    apt-get update && \
    apt-get install -y lsb-release ca-certificates curl gnupg && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -sSL https://packages.sury.org/php/apt.gpg \
        | gpg --dearmor -o /etc/apt/keyrings/sury-php.gpg && \
    chmod a+r /etc/apt/keyrings/sury-php.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/sury-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" \
        > /etc/apt/sources.list.d/php.list && \
    apt-get update && \
    apt-get install -y \
        php8.5-fpm php8.5-gd php8.5-mysql php8.5-cli php8.5-common \
        php8.5-curl php8.5-intl php8.5-mbstring php8.5-xml \
        imagemagick \
        git \
        subversion \
        unzip \
        supervisor && \
    rm -rf /var/lib/apt/lists/*

# Using www-data user
RUN sed -i 's/user  nginx/user  www-data/g' /etc/nginx/nginx.conf

COPY --from=composer:2.10.1 /usr/bin/composer /usr/local/bin/composer
