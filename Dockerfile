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
    apt-transport-https

RUN echo "date.timezone = America/Sao_Paulo" >> /etc/php/7.0/cli/php.ini

COPY composer-install /
RUN bash composer-install
RUN rm composer-install
