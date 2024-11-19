# README

This README would normally document whatever steps are necessary to get the
application up and running.

# Gestion Recettes Culinaires

**Gestion Recettes Culinaires** est une application pour gérer et visualiser des recettes de cuisine, construite avec Ruby on Rails et tournant dans un environnement Docker.

## Prérequis

- **Docker** : Assurez-vous que Docker et Docker Compose sont installés sur votre machine.
- **Ruby on Rails** : L'application est configurée pour fonctionner avec Docker, donc une installation locale de Ruby on Rails n'est pas nécessaire.

## Installation et démarrage

Suivez les étapes ci-dessous pour cloner le projet, configurer et démarrer l'application.

1. **Clonez le dépôt** :
   ```bash
   git clone https://github.com/user-manasse/gestion_recettes_culinaires.git
   cd gestion_recettes_culinaires
- **Modifier des informations de connéxion à la base de données**: Modifier dans le .env le nom de l'utilisateur, et le mot de pass, ainsi que le nom de la base de donnée

2. **Construisez les images Docker** :
   ```bash
   docker compose build

- **Initialisez la base de données, Lancez l'application**

   docker compose run web rails db:create db:migrate
   docker compose up

3. **Accéder à l'application ** :
    Ouvrez votre navigateur et accédez à http://localhost:3092 pour voir l'application en fonctionnement.