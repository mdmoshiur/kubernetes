FROM php:8.0.7-fpm

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libmcrypt-dev \
    curl \
    jq \
    xvfb libfontconfig wkhtmltopdf \
    libjpeg-dev \
    libpng-dev \
    zlib1g-dev \
    && docker-php-ext-install -j$(nproc) pdo \
    && docker-php-ext-install -j$(nproc) pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && docker-php-ext-install  mbstring \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install bcmath

RUN apt-get install -y \
        libzip-dev \
        zip \
  && docker-php-ext-install zip

RUN apt-get install nano -y

RUN pecl install redis opcache
RUN docker-php-ext-enable opcache

RUN apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*