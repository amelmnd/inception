FROM alpine:3.20

RUN apk update && apk upgrade && apk add --no-cache nginx mariadb mariadb-client mariadb-server-utils

WORKDIR /root/

COPY ./tools/amennad.sh  .

CMD chmod +x ./amennad.sh

EXPOSE 3306

ENTRYPOINT ./amennad.sh
