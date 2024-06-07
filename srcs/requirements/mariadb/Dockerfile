FROM alpine:3.19

WORKDIR /root/

COPY ./tools/amennad.sh  .

CMD chmod +x ./amennad.sh

EXPOSE 3306

ENTRYPOINT ./amennad.sh
