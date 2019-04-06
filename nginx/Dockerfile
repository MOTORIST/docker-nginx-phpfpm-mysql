FROM nginx:1.15.10-alpine

MAINTAINER Gerasin Ivan <webartmotor@gmail.com>

RUN apk upgrade --update \
    && apk --no-cache add -f bash

# ensure www-data user exists
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1;

COPY docker-entrypoint.sh /
COPY ./conf/mime.types /etc/nginx/mime.types
COPY ./conf/nginx.template /etc/nginx/nginx.template
COPY ./conf/ssl.redirect.template /etc/nginx/ssl.redirect.template
COPY ./conf/ssl_config.template /etc/nginx/ssl_config.template

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]