apk add nginx netcat-openbsd openssl
echo "waiting for wp"

while nc -z wordpress 9000 &>/dev/null; [ $? != 0 ]; do
	sleep 1
done
echo " done waiting for wp"


if [ ! -f "/etc/ssl/nginx-key.pem" ]; then
	echo "generating ssl certificate"
	cd /etc/ssl
	openssl req -x509 -newkey rsa:4096 \
		-keyout nginx-key.pem \
		-out nginx-cert.pem \
		-sha256 \
		-days 365 \
		-nodes \
		-subj "/C=XX/ST=France/L=Nice/O=42" &>/dev/null
	echo "Generated certificate and key"
fi

nginx -g "daemon off;"
