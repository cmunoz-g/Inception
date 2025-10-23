FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y mariadb-server

COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /etc/mysql/init.sql
COPY mdb.sh .

RUN mkdir /run/mysqld
RUN chmod +x mdb.sh

CMD ["./mdb.sh"]