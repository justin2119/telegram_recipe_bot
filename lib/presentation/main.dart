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
    print('Error: TELEGRAM_BOT_TOKEN not found in .env file');
    exit(1);
  }

  final username = (await Telegram(botToken).getMe()).username;
  var teledart = TeleDart(botToken, Event(username!));
  final repository = RecipeRepositoryImpl();

  teledart.start();

  // /start
  teledart.onCommand('start').listen((message) {
    message.reply('Welcome to the Culinary Recipe Bot!\n\n'
        'Commands:\n'
        '/addrecipe <title> | <ingredients> | <instructions>\n'
        '/recipe <title>\n'
        '/listrecipes');
  });

  // /addrecipe <title> | <ingredients> | <instructions>
  teledart.onCommand('addrecipe').listen((message) async {
    final text = message.text?.replaceFirst('/addrecipe', '').trim() ?? '';
    final parts = text.split('|').map((e) => e.trim()).toList();

    if (parts.length < 3) {
      message.reply('Usage: /addrecipe Title | Ingredients | Instructions');
      return;
    }

    final recipe = Recipe(
      title: parts[0],
      ingredients: parts[1],
      instructions: parts[2],
    );

    await repository.addRecipe(recipe);
    message.reply('Recipe "${recipe.title}" added successfully!');
  });

  // /recipe <title>
  teledart.onCommand('recipe').listen((message) async {
    final title = message.text?.replaceFirst('/recipe', '').trim() ?? '';
    if (title.isEmpty) {
      message.reply('Usage: /recipe <title>');
      return;
    }

    final recipe = await repository.getRecipeByTitle(title);
    if (recipe != null) {
      message.reply('🍳 *${recipe.title}*\n\n'
          '🛒 *Ingredients:*\n${recipe.ingredients}\n\n'
          '📖 *Instructions:*\n${recipe.instructions}',
          parse_mode: 'Markdown');
    } else {
      message.reply('Recipe "$title" not found.');
    }
  });

  // /listrecipes
  teledart.onCommand('listrecipes').listen((message) async {
    final recipes = await repository.getAllRecipes();
    if (recipes.isEmpty) {
      message.reply('No recipes found yet.');
      return;
    }

    final list = recipes.map((r) => '• ${r.title}').join('\n');
    message.reply('Your Recipes:\n$list');
  });

  print('Recipe Bot is running...');
}
