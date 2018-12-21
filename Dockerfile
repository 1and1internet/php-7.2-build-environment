FROM ubuntu:18.04
MAINTAINER developmentteamserenity@fasthosts.com

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      curl \
      git \
      jq \
      mysql-client \
      nano \
      software-properties-common \
      tzdata \
      unzip \
      vim \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      php7.2-bcmath \
      php7.2-bz2 \
      php7.2-cli \
      php7.2-curl \
      php7.2-gd \
      php7.2-json \
      php7.2-mbstring \
      php7.2-mysql \
      php7.2-opcache \
      php7.2-readline \
      php7.2-sqlite3 \
      php7.2-xml \
      php7.2-zip \
      php-amqp \
      php-ldap \
      php-redis \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -y \
      software-properties-common \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove --purge -y \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app/
RUN chown 1000:1000 /app
USER 1000
ENV HOME /tmp

COPY --chown=1000:1000 --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN composer global require hirak/prestissimo && composer clear-cache