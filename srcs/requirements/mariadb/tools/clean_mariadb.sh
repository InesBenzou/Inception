#!/bin/bash

if [ -f /var/lib/mysql/mysql.pid ]; then
	echo "Suppression de mysql.pid..."
	rm -f /var/lib/mysql/mysql.pid
fi

if [ -f /var/lib/mysql/mysql.sock ]; then
	echo "Supression de mysql.sock..."
	rm -f /var/lib/mysql/mysql.sock
fi

if [ -f /var/lib/mysql/mysql.sock.lock ]; then
	echo "Suppression de mysql.sock.lock..."
	rm -f /var/lib/mysql/mysql.sock.lock
fi

echo "Nettoyage des fichiers de verrouillage termine."

#if [ ! -d /var/lib/mysql/mysql ]; then
#	echo "Initialisation de la base de donnees MariaDB..."
#	mysql_install_db --user=mysql --datadir=/var/lib/mysql
#fi

#echo "Demarrage de MariaDB..."
#exec mysql --user=mysql 
