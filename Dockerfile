FROM php:7-fpm-alpine

RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community gnu-libiconv

RUN apk add --no-cache \
  freetype \
  libpng \
  libjpeg-turbo \
  freetype-dev \
  libpng-dev \
  libcurl \
  libjpeg-turbo-dev && \
  
  docker-php-ext-configure gd \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ && \
  NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \

  docker-php-ext-install -j${NPROC} gd && \
  apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev  && \
  apk add --no-cache nodejs npm

RUN docker-php-ext-install mysqli pdo pdo_mysql          

RUN apk add --no-cache composer curl \
        php7 \
        php7-fpm \
        php7-gd \
        php7-intl \
        php7-opcache \
        php7-xmlrpc \
        php7-xmlwriter \
        php7-tokenizer \
        php7-fileinfo \
        php7-common \

        php7-exif \
        php7-bcmath \
        php7-zip \
        php7-xsl \
        php7-xml \
        php7-soap \
        php7-mbstring \
        php7-simplexml \
        php7-redis \

        musl \
        php7-pdo \
        php7-mysqlnd \

        php7-pdo_mysql \
        php7-pdo_pgsql \
        php7-pdo_sqlite \
        php7-fileinfo \
        php7-ctype \
        php7-memcached \
        php7-curl \

        php7-json \
        php7-session && \
        rm -Rf /var/cache/apk/*



ENV TZ=Asia/Jakarta
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
