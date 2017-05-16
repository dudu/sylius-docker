FROM ubuntu:latest

MAINTAINER eduardo@eduardonascimento.com.br

RUN apt-get update \
    && apt-get install -y php7.0 \
    curl \
    php7.0-curl \
    php7.0-intl \
    php7.0-mbstring \
    php7.0-gd \
    php7.0-xml \
    php7.0-mysql \
    wget \
    curl \
    git \
    unzip \
    curl \
    nodejs \
    npm \
    apt-transport-https \
    nginx

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y yarn

RUN export PATH="$HOME/.yarn/bin:$PATH"

RUN echo "date.timezone = America/Sao_Paulo" >> /etc/php/7.0/cli/php.ini

COPY composer-install /
RUN bash composer-install
RUN rm composer-install

ENV MYSQL_USER=mysql \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server

COPY mysql-start /
RUN bash mysql-start