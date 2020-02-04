FROM alpine:3.11
LABEL maintainer="Alexandre Schwartzmann <admin@arcanexus.com>"

ENV \
  HOME="/root" \
  PS1="$(whoami)@$(hostname):$(pwd)$ "

RUN echo "====== INSTALL BASE PACKAGES ======" \
  && apk --update upgrade \
  && apk add openrc bash ca-certificates coreutils file libressl logrotate shadow tzdata git \
  \
  && echo "====== INSTALL WEBSERVER PACKAGES ======" \
  && apk add nginx certbot libgd libxslt pcre certbot-nginx \
  && apk add php7 php7-openssl php7-mbstring php7-gd php7-gettext   \
  \
  && echo "====== CONFIGURE PHP ======" \
  && sed -i 's/index.html/index.php index.html/g' /etc/nginx/nginx.conf \
  \
  && echo "====== CLEANUP ======" \
  && rm -rf /tmp/* /usr/src/* /var/cache/apk/*

EXPOSE 80/tcp 443/tcp