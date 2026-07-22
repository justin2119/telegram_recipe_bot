---
title: Telegram Recipe Bot
emoji: 👨‍🍳
colorFrom: yellow
colorTo: orange
sdk: docker
app_port: 7860
license: mit
---

# 👨‍🍳 Telegram Recipe Bot — C'est Carré !

Wesh mon reuf ! Bienvenue sur le repo du **Telegram Recipe Bot**. C'est le bot ultime pour gérer tes meilleures recettes, du Fufu bien pilonné aux plats internationaux, le tout avec une architecture propre (Clean Arch).

Ce projet est configuré pour tourner sur **Hugging Face Spaces** via Docker.

## 🌍 Déploiement sur Hugging Face Spaces

Le bot expose un serveur HTTP léger sur le port **7860** pour passer les "health checks" de Hugging Face.

1.  Crée un nouveau Space sur Hugging Face.
2.  Choisis **Docker** comme SDK.
3.  Ajoute ton `TELEGRAM_BOT_TOKEN` dans les **Settings > Variables and secrets** du Space.
4.  C'est tout, Hugging Face va build et run le bouzin automatiquement.

## 🕹 Les Commandes (Les bails dispos)

- `/start` : Le bot te fait un check et te montre les bails.
- `/listrecipes` : Affiche tout le catalogue des recettes en DB.
- `/recipe <titre>` : Te sort la description, le temps, "Le matos" et "Le process" d'une recette.
- `/addrecipe <titre> | <desc> | <temps> | <matos> | <process>` : Pour push tes propres bails.

C'est propre, c'est carré, bon appétit mon reuf ! ✌️
