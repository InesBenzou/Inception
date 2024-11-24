FROM debian:bullseye 

RUN apt update -y && apt upgrade -y && apt install -y mariadb-server mariadb-client


COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

COPY tools/script.sh ./tools/script.sh

RUN chown -R mysql:mysql /var/lib/mysql;\
	mkdir -p /run/mysqld;\
	chown -R mysql:mysql /run/mysqld;\
	mysql_install_db --datadir=/var/lib/mysql --user=mysql



EXPOSE 3306
ENTRYPOINT ["./tools/script.sh"]

#ENTRYPOINT ["bash", "/usr/local/bin/clean_mariadb.sh", "./tools/script.sh"]

#ENTRYPOINT ["bash", "script.sh"]

#RUN mkdir -p /run/mysqld /var/lib/mysql ;\
#	chown -R mysql:mysql /var/lib/mysql /run/mysqld;\
#	mysql_install_db --datadir=/var/lib/mysql --user=mysql

