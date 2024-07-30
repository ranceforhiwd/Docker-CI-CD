# Download base with Ubuntu and php 8.2
 
FROM amd64/php:8.2-cli
COPY . /usr/run/php
 
#Update Ubuntu Software repository
RUN apt-get update
 
# Install packages
RUN set -x \
  && apt-get install -y wget \
    software-properties-common \
    build-essential \
    git \
    nano
 
#install ghostscript
RUN apt -y install ghostscript
 
RUN apt-get update && apt-get install -y \
    zip \
    unzip
 
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
WORKDIR /usr/run/php

RUN composer require aws/aws-sdk-php

# Install PostgreSQL client and its PHP extensions
RUN apt-get install -y libpq-dev \
    && docker-php-ext-install pgsql pdo_pgsql pdo
 
#WORKDIR /usr/run/php
#CMD [ "php", "index.php" ]