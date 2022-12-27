# docker-nginx-php
Basic Docker configuration for a NGINX and PHP image

Check branches for different versions

https://hub.docker.com/repository/docker/toniher/nginx-php

```
docker buildx build  --platform=linux/amd64,linux/arm64,linux/arm/v7 --push -t toniher/nginx-php:nginx-1.23-php-8.1-sury .
```


