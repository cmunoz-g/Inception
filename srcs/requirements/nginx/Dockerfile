FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y nginx openssl

COPY default /etc/nginx/sites-available/default
COPY nginx.sh .

RUN chmod +x nginx.sh

EXPOSE 443

CMD ["./nginx.sh"]