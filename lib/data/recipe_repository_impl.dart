import 'dart:convert';
import 'dart:io';
import '../domain/recipe.dart';
import 'recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final String filePath = 'recipes.json';

  final List<RecipeModel> _defaultRecipes = [
    RecipeModel(
      title: 'Fufu with Peanut Soup',
      ingredients: 'Yams or Cassava, Water, Peanut butter, Meat or Fish, Spices',
      instructions: '1. Boil and pound the yams until doughy.\n2. Prepare peanut soup with meat and spices.\n3. Serve fufu balls in the soup.',
    ),
    RecipeModel(
      title: 'Atakpamé (Ablo)',
      ingredients: 'Corn flour, Rice flour, Sugar, Yeast, Water',
      instructions: '1. Mix flours with water, yeast, and sugar.\n2. Let ferment for several hours.\n3. Steam in small molds until fluffy.',
    ),
    RecipeModel(
      title: 'Jollof Rice',
      ingredients: 'Rice, Tomatoes, Onions, Peppers, Spices, Oil',
      instructions: '1. Sauté onions and peppers.\n2. Add tomato paste and spices.\n3. Add rice and broth, then simmer until cooked.',
    ),
  ];

  Future<void> _saveToFile(List<RecipeModel> recipes) async {
    final file = File(filePath);
    final jsonString = jsonEncode(recipes.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final file = File(filePath);
    
    if (!await file.exists()) {
      await _saveToFile(_defaultRecipes);
      return _defaultRecipes;
    }
    
    final jsonString = await file.readAsString();
    if (jsonString.trim().isEmpty) {
      await _saveToFile(_defaultRecipes);
      return _defaultRecipes;
    }

    try {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((e) => RecipeModel.fromJson(e)).toList();
    } catch (e) {
      // If file is corrupted, fallback to defaults
      await _saveToFile(_defaultRecipes);
      return _defaultRecipes;
    }
  }

  @override
  Future<Recipe?> getRecipeByTitle(String title) async {
    final recipes = await getAllRecipes();
    try {
      return recipes.firstWhere((r) => r.title.toLowerCase() == title.toLowerCase());
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> addRecipe(Recipe recipe) async {
    final recipes = await getAllRecipes();
    final models = recipes.map((e) => RecipeModel(
      title: e.title,
      ingredients: e.ingredients,
      instructions: e.instructions,
    )).toList();
    
    models.add(RecipeModel(
      title: recipe.title,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
    ));
    
    await _saveToFile(models);
  }
}
