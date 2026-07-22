import 'dart:convert';
import 'dart:io';
import '../domain/recipe.dart';
import 'recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final String filePath = 'recipes.json';

  final List<RecipeModel> _defaultRecipes = [
    RecipeModel(
      title: 'Fufu',
      ingredients: 'Igname (ou manioc), Eau',
      instructions: '1. Faire bouillir l\'igname.\n2. Piler l\'igname jusqu\'à obtenir une pâte élastique et homogène.\n3. Servir chaud avec une sauce (graine ou arachide).',
    ),
    RecipeModel(
      title: 'Ablo',
      ingredients: 'Farine de maïs, Farine de riz, Sucre, Levure, Eau',
      instructions: '1. Mélanger les farines avec l\'eau, la levure et le sucre.\n2. Laisser fermenter pendant quelques heures.\n3. Cuire à la vapeur dans des petits moules jusqu\'à ce que ce soit bien moelleux.',
    ),
    RecipeModel(
      title: 'Riz au Gras / Jollof Togolais',
      ingredients: 'Riz, Tomates, Oignons, Poivrons, Viande ou Poisson, Huile, Épices',
      instructions: '1. Faire revenir la viande et les oignons.\n2. Ajouter la tomate concentrée et les légumes mixés.\n3. Ajouter le riz et le bouillon, puis laisser cuire à feu doux jusqu\'à absorption totale.',
    ),
    RecipeModel(
      title: 'Akpan',
      ingredients: 'Farine de maïs fermentée, Eau, Lait (optionnel), Sucre',
      instructions: '1. Délayer la pâte de maïs fermentée dans de l\'eau.\n2. Cuire à feu moyen en remuant constamment jusqu\'à épaississement.\n3. Laisser refroidir et servir avec du lait et du sucre.',
    ),
    RecipeModel(
      title: 'Djenkoumé',
      ingredients: 'Farine de maïs rouge (grillée), Tomates, Oignons, Huile, Bouillon de poulet',
      instructions: '1. Préparer une sauce tomate bien assaisonnée.\n2. Ajouter le bouillon de poulet.\n3. Verser la farine de maïs en pluie tout en remuant vigoureusement jusqu\'à obtenir une pâte consistante.',
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
