FROM debian:buster 

# installing packages
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install mariadb-server -y && apt-get install vim -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/db.sh .

RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld /var/lib/mysql
RUN chmod +x db.sh

CMD ["./db.sh"]

# /var/run/mysqld/mysqld.sock