# 👨‍🍳 Telegram Recipe Bot — C'est Carré !

Wesh mon reuf ! Bienvenue sur le repo du **Telegram Recipe Bot**. C'est le bot ultime pour gérer tes meilleures recettes, du Fufu bien pilonné aux plats internationaux, le tout avec une architecture propre (Clean Arch) pour que le code soit aussi propre que ton plan de travail.

## 🚀 Le Projet

C'est un bot Telegram build avec **Dart** et **TeleDart**. Il gère une base de données locale en JSON (`recipes.json`) pour que tes bails culinaires soient persistés. Si tu lances le bot pour la première fois et que la DB est vide, pas de panique : on a injecté les 5 classiques du Togo en mode authentique pour que tu puisses tester direct.

### 🛠 Tech Stack
- **Language :** Dart (>=3.0.0)
- **Framework Bot :** TeleDart
- **Architecture :** Clean Architecture (Core, Domain, Data, Presentation)
- **Persistence :** Local JSON storage
- **Config :** Dotenv pour les secrets

## ⚙️ Setup (Le déploiement en prod)

Pour faire tourner le bouzin sur ta bécane, suis le process :

1.  **Clone le repo :**
    ```bash
    git clone https://github.com/justin2119/telegram_recipe_bot.git
    cd telegram_recipe_bot
    ```

2.  **Install les dépendances :**
    ```bash
    dart pub get
    ```

3.  **Config le .env :**
    Crée un fichier `.env` à la racine et mets ton token Telegram dedans.
    ```env
    TELEGRAM_BOT_TOKEN=ton_token_ici
    ```

4.  **Run le bot :**
    ```bash
    dart run lib/presentation/main.dart
    ```

Si tu vois "Le Recipe Bot est on-line, prêt à charbonner...", c'est que c'est carré !

## 🕹 Les Commandes (Les bails dispos)

- `/start` : Le bot te fait un check et te montre les bails.
- `/listrecipes` : Affiche tout le catalogue des recettes en DB.
- `/recipe <titre>` : Te sort "Le matos" (ingrédients) et "Le process" (instructions) détaillés d'une recette.
- `/addrecipe <titre> | <matos> | <process>` : Pour push tes propres bails dans la base. Attention à bien utiliser le pipe `|` pour séparer les infos.

## 🇹🇬 Le Catalogue Togolais (Default Pack)

On t'a mis bien avec 5 recettes authentiques déjà intégrées :
- **Fufu** : L'incontournable igname pilonnée.
- **Ablo** : Les petits pains de maïs vapeur, super moelleux.
- **Riz au Gras / Jollof Togolais** : Le riz rouge qui met tout le monde d'accord.
- **Akpan** : Le dessert glacé à base de maïs fermenté, frais de ouf.
- **Djenkoumé** : La pâte rouge à la tomate et au bouillon de poulet.

## 🧱 Architecture

Le projet est découpé proprement pour pas que ce soit le zbeul :
- `lib/core/` : Les erreurs et les helpers.
- `lib/domain/` : Les entités et les contrats des repos.
- `lib/data/` : L'implémentation des repos et les modèles JSON.
- `lib/presentation/` : Le point d'entrée du bot et la logique des commandes.

C'est propre, c'est carré, bon appétit mon reuf ! ✌️
