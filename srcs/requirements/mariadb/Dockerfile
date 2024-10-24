FROM debian:buster 

# installing packages
RUN apt update -y && apt upgrade -y
RUN apt-get install mariadb-server -y 
# do we need to enable it ? (https://aymeric-cucherousset.fr/installer-mariadb-sur-debian-11/)

# copying the configuration file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
