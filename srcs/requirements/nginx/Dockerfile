FROM alpine:3.19

WORKDIR /root/

COPY ./tools/amennad.sh .
COPY ./conf/nginx.conf /etc/nginx/http.d/default.conf
CMD chmod +x ./amennad.sh

EXPOSE 443

ENTRYPOINT ./amennad.sh
