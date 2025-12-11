FROM debian:12

RUN apt-get update

RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

COPY ./tools/cert.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/cert.sh

COPY ./conf/nginx.conf /etc/nginx/conf.d/nginx.conf

CMD ["cert.sh"]
