FROM debian:buster 

# installing packages
RUN apt update -y && apt install nginx -y 
RUN apt install vim -y

# installing openssl, generating certificate and storing it
RUN mkdir -p /etc/nginx/ssl

