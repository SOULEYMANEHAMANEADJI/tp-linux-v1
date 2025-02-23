# README - TP Linux (DEVOPS-DITI5)

## Introduction

Ce document fournit un aperçu détaillé du projet de création d'une machine virtuelle à l'aide de Vagrant dans le cadre de l'exercice TP Linux pour le cours DEVOPS-DITI5. L'objectif principal est de configurer un environnement de développement avec Nginx et MySQL.

## Pré-requis

Avant de commencer, assurez-vous d'avoir installé :
- **Vagrant**
- **VirtualBox**
- **Git** (optionnel, pour le contrôle de version)

## Configuration de Vagrant

La configuration de la machine virtuelle est définie dans le fichier `Vagrantfile`. Voici les principales sections :

### 1. Configuration de la box

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
```

### 2. Redirection des ports

Nous avons mappé les ports nécessaires pour Nginx et MySQL :

```ruby
config.vm.network "forwarded_port", guest: 80, host: 8080  # Nginx
config.vm.network "forwarded_port", guest: 3306, host: 3306  # MySQL
```

### 3. Provisioning

La configuration de provisioning utilise un script shell nommé `provision.sh` :

```ruby
config.vm.provision "shell", path: "provision.sh"
end
```

## Démarrer la machine virtuelle

Pour initialiser et démarrer votre machine virtuelle, suivez ces étapes :

1. Créez un nouveau répertoire pour le projet :
   ```bash
   mkdir tp-linux
   cd tp-linux
   vagrant init
   ```

2. Validez le fichier `Vagrantfile` :
   ```bash
   vagrant validate
   ```

3. Démarrez la machine virtuelle :
   ```bash
   vagrant up
   ```

## Connexion à la machine virtuelle

Accédez à la machine virtuelle via SSH :

```bash
vagrant ssh
```

### Vérification de l'installation de MySQL

Une fois connecté, vous pouvez vérifier l'installation de MySQL :

```bash
mysql -h 127.0.0.1 -P 3306 -u vagrant -pvagrantpass
```

Pour créer une base de données :

```sql
CREATE DATABASE devops_db;
```

### Vérification du serveur Nginx

Accédez à http://localhost:8080 pour vérifier que Nginx fonctionne correctement. Vous devriez voir un message de bienvenue indiquant que Nginx est installé.

## Conclusion

Ce TP a permis de mettre en place une machine virtuelle utilisant Vagrant, configurée avec Nginx et MySQL. Cette approche facilite le développement et le déploiement d'applications dans un environnement isolé et facilement reproductible.

### Aide supplémentaire

Pour toute question ou besoin d'assistance, n'hésitez pas à consulter la [documentation officielle de Vagrant](https://www.vagrantup.com/docs) ou à contacter l'instructeur du cours.
