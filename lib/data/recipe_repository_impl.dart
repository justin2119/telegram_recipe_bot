import 'dart:convert';
import 'dart:io';
import '../domain/recipe.dart';
import 'recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final String filePath = 'recipes.json';

  Future<void> _saveToFile(List<RecipeModel> recipes) async {
    final file = File(filePath);
    final jsonString = jsonEncode(recipes.map((e) => e.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final file = File(filePath);
    if (!await file.exists()) return [];
    
    final jsonString = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((e) => RecipeModel.fromJson(e)).toList();
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
