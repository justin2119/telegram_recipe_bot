# Utilise une image Dart officielle
FROM dart:stable AS build

# Crée le dossier de l'app
WORKDIR /app

# Copie les fichiers de deps
COPY pubspec.* .
RUN dart pub get

# Copie tout le code
COPY . .

# Compile l'exécutable pour que ça bombarde
RUN dart compile exe lib/presentation/main.dart -o recipe_bot

# Image finale ultra légère
FROM debian:bookworm-slim

WORKDIR /app

# Copie l'exécutable depuis le build
COPY --from=build /app/recipe_bot /app/recipe_bot
# Copie la DB initiale et le .env
COPY recipes.json /app/recipes.json

# Lance le bouzin
CMD ["/app/recipe_bot"]
