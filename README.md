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

## ⚙️ Setup (Installation rapide)

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

4.  **Run le bot (mode dev) :**
    ```bash
    dart run lib/presentation/main.dart
    ```

## 🌍 Déploiement 24/7 (Mode Charbonneur)

Si tu veux que ton bot tourne non-stop sur ton VPS sans crash, on a ce qu'il faut.

### Option A : Docker (Le bail le plus propre)

1.  **Build l'image :**
    ```bash
    docker build -t recipe-bot .
    ```

2.  **Lance le container :**
    ```bash
    docker run -d --restart always --name my-recipe-bot --env-file .env recipe-bot
    ```

### Option B : Systemd (Direct sur ton Linux)

1.  **Build l'exécutable :**
    ```bash
    dart compile exe lib/presentation/main.dart -o recipe_bot
    ```

2.  **Config le service :**
    Copie le fichier `recipe_bot.service` dans `/etc/systemd/system/`.
    ```bash
    sudo cp recipe_bot.service /etc/systemd/system/
    sudo systemctl daemon-reload
    sudo systemctl enable recipe_bot
    sudo systemctl start recipe_bot
    ```

## 🕹 Les Commandes (Les bails dispos)

- `/start` : Le bot te fait un check et te montre les bails.
- `/listrecipes` : Affiche tout le catalogue des recettes en DB.
- `/recipe <titre>` : Te sort la description, le temps, "Le matos" et "Le process" d'une recette.
- `/addrecipe <titre> | <desc> | <temps> | <matos> | <process>` : Pour push tes propres bails.

## 🇹🇬 Le Catalogue Togolais (Default Pack)

On t'a mis bien avec 50 recettes authentiques déjà intégrées, dont :
- **Fufu** : L'incontournable igname pilonnée.
- **Ablo** : Les petits pains de maïs vapeur.
- **Djenkoumé** : La pâte rouge à la tomate.
- *Et 47 autres bails de qualité.*

C'est propre, c'est carré, bon appétit mon reuf ! ✌️
