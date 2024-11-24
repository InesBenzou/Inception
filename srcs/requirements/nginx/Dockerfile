FROM debian:bullseye 

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /run/nginx

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx-selfsigned.key \
	-out /etc/nginx/ssl/nginx-selfsigned.crt \
	-subj "/C=FR/ST=IDF/L=Paris/O=42Paris/OU=Cadet/CN=ibenzian.42.fr" #Added line

COPY conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
