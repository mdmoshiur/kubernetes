FROM php:8.0.7-fpm

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    libmemcached-dev \
    libz-dev \
    libpq-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    supervisor \
    nano \
    zip unzip \
    libssh2-1-dev \
    openssl \
    libxml2-dev \
    libonig-dev \
    libcurl4-openssl-dev

RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip


# Install the PHP  extention
RUN docker-php-ext-install pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd mysqli

#composer setup
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


#RUN pecl install -o -f redis \
#    &&  rm -rf /tmp/pear \
#    &&  echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini

RUN pecl install redis opcache
RUN docker-php-ext-enable opcache

RUN apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*
