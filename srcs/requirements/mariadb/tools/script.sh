#!/bin/bash

echo "Initialisation de l'environnement MariaDB..."

# Créer les dossiers nécessaires et définir les permissions
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql


if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initialisation des fichiers de données..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

echo "Démarrage de MariaDB pour configuration initiale..."
mysqld_safe --datadir=/var/lib/mysql &


echo "Attente du démarrage de MariaDB..."
until mysqladmin ping -h localhost --silent; do
    sleep 2
done


echo "Configuration de MariaDB..."
mysql <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOSQL


echo "Arrêt temporaire de MariaDB..."
mysqladmin shutdown


echo "Lancement final de MariaDB..."
exec mysqld --datadir=/var/lib/mysql --user=mysql

