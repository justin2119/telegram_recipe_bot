import 'dart:io';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:dotenv/dotenv.dart';
import '../data/recipe_repository_impl.dart';
import '../domain/recipe.dart';

void main() async {
  var env = DotEnv()..load();
  final String botToken = env['TELEGRAM_BOT_TOKEN'] ?? '';

  if (botToken.isEmpty) {
    print('Erreur : TELEGRAM_BOT_TOKEN manquant dans le .env mon reuf');
    exit(1);
  }

  final username = (await Telegram(botToken).getMe()).username;
  var teledart = TeleDart(botToken, Event(username!));
  final repository = RecipeRepositoryImpl();

  teledart.start();

  // /start
  teledart.onCommand('start').listen((message) {
    teledart.sendChatAction(message.chat.id, 'typing');
    message.reply('Bienvenue sur le Recipe Bot, c\'est carré ! 👨‍🍳\n\n'
        'Les bails dispos :\n'
        '/addrecipe <titre> | <ingrédients> | <instructions> — Pour push une nouvelle recette\n'
        '/recipe <titre> — Pour check une recette spécifique\n'
        '/listrecipes — Pour voir tout le catalogue');
  });

  // /addrecipe <title> | <ingredients> | <instructions>
  teledart.onCommand('addrecipe').listen((message) async {
    teledart.sendChatAction(message.chat.id, 'typing');
    final text = message.text?.replaceFirst('/addrecipe', '').trim() ?? '';
    final parts = text.split('|').map((e) => e.trim()).toList();

    if (parts.length < 3) {
      message.reply('Mauvais format mon reuf. Utilise : /addrecipe Titre | Ingrédients | Instructions');
      return;
    }

    final recipe = Recipe(
      title: parts[0],
      ingredients: parts[1],
      instructions: parts[2],
    );

    await repository.addRecipe(recipe);
    message.reply('La recette "${recipe.title}" a été déployée en prod, c\'est propre ! ✅');
  });

  // /recipe <title>
  teledart.onCommand('recipe').listen((message) async {
    teledart.sendChatAction(message.chat.id, 'typing');
    final title = message.text?.replaceFirst('/recipe', '').trim() ?? '';
    if (title.isEmpty) {
      message.reply('Il me faut un titre mon reuf. Usage : /recipe <titre>');
      return;
    }

    final recipe = await repository.getRecipeByTitle(title);
    if (recipe != null) {
      message.reply('🍳 *${recipe.title}*\n\n'
          '🛒 *Le matos (Ingrédients) :*\n${recipe.ingredients}\n\n'
          '📖 *Le process (Instructions) :*\n${recipe.instructions}',
          parseMode: 'Markdown');
    } else {
      message.reply('Désolé mon reuf, la recette "$title" est introuvable dans la db.');
    }
  });

  // /listrecipes
  teledart.onCommand('listrecipes').listen((message) async {
    teledart.sendChatAction(message.chat.id, 'typing');
    final recipes = await repository.getAllRecipes();
    if (recipes.isEmpty) {
      message.reply('Le catalogue est vide pour l\'instant, y\'a rien à build.');
      return;
    }

    final list = recipes.map((r) => '• ${r.title}').join('\n');
    message.reply('Toutes les recettes dispo mon reuf :\n$list\n\nC\'est carré !');
  });

  print('Le Recipe Bot est on-line, prêt à charbonner...');
}
