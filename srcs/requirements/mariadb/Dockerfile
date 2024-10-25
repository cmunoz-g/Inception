FROM debian:buster 

# installing packages
RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y 

# do we need to enable it ? (https://aymeric-cucherousset.fr/installer-mariadb-sur-debian-11/)

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/db.sh .

RUN chmod +x db.sh

CMD ["./db.sh"]
