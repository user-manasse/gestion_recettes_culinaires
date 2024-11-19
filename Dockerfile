# Utiliser une image officielle Ruby comme base
FROM ruby:3.2.0

# Installer les dépendances système
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de l'application dans le conteneur
COPY Gemfile Gemfile.lock ./

# Installer les gems
RUN bundle install

# Copier le reste des fichiers du projet dans le conteneur
COPY . .

# Exposer le port 3000 pour l'application Rails
EXPOSE 3092

# Démarrer le serveur Rails
CMD ["rails", "server", "-b", "0.0.0.0"]