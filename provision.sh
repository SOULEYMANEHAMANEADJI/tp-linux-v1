#!/bin/bash

# Mise à jour du système
apt-get update

# 1. Installation de Nginx
apt-get install -y nginx
systemctl start nginx
systemctl enable nginx

# 2. Déploiement de l'application front
echo "<!DOCTYPE html>
<html>
<head>
    <title>TP Linux</title>
</head>
<body>
    <h1>Bienvenue sur le TP Linux (DEVOPS-DITI5) !</h1>
    <p>Nginx est correctement installé 🎉</p>
</body>
</html>" > /var/www/html/index.html

# 3. Installation de MySQL Server
export DEBIAN_FRONTEND=noninteractive
debconf-set-selections <<< 'mysql-server mysql-server/root_password password rootpass'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password rootpass'
apt-get install -y mysql-server

# Configuration MySQL pour accepter les connexions distantes
sed -i 's/bind-address.*= 127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

# Redémarrage de MySQL
systemctl restart mysql

# Création d'un utilisateur MySQL avec accès distant
mysql -u root -prootpass <<EOF
CREATE USER 'vagrant'@'%' IDENTIFIED BY 'vagrantpass';
GRANT ALL PRIVILEGES ON *.* TO 'vagrant'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF