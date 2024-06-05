FROM alpine:3.19

WORKDIR /root/

COPY ./tools/amennad.sh .
COPY ./conf/www.conf /etc/php83/php-fpm.d/www.conf
RUN chmod +x ./amennad.sh

EXPOSE 9000

ENTRYPOINT ./amennad.sh
