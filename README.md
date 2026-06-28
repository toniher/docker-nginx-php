# docker-nginx-php

Docker image combining NGINX and PHP-FPM in a single container, intended as a base for PHP web applications.

## Current versions

| Component | Version  | Source          |
|-----------|----------|-----------------|
| NGINX     | 1.30     | official image  |
| PHP       | 8.5      | packages.sury.org |
| Composer  | 2.10.1   | official image  |

## Included PHP extensions

`php8.5-fpm`, `php8.5-gd`, `php8.5-mysql`, `php8.5-cli`, `php8.5-common`, `php8.5-curl`, `php8.5-intl`, `php8.5-mbstring`, `php8.5-xml`

## Other tools

`imagemagick`, `git`, `subversion`, `unzip`, `supervisor`

## Build

```bash
docker buildx build \
  --platform=linux/amd64,linux/arm64,linux/arm/v7 \
  --push \
  -t toniher/nginx-php:nginx-1.30-php-8.5 .
```

## Branches

Each branch targets a specific NGINX + PHP version combination. See all available tags on Docker Hub.

- `nginx-1.30-php-8.5-sury` — current
- `nginx-1.29-php-8.4-sury`
- `nginx-1.27-php-8.3-sury`
- `nginx-1.27-php-8.2`
- `nginx-1.23-php-8.1-sury`
- `nginx-1.23-php-7.4`
- older branches back to nginx 1.10 / PHP 5.6

## Docker Hub

https://hub.docker.com/repository/docker/toniher/nginx-php
